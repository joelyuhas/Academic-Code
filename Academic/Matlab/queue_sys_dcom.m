% System of queues simulation on Matlab

clear all;
close all;

delta = 1e-5; % simulation step in sec
simlen = 0.1; % simulation duration in minutes
M = round(simlen*60/delta); % number of simulation step for 50 hours, in units of delta
% Nnodes = 2;

% Node type
% 0 = source node
% 1 = routing node
% 2 = sink node
NodeType = [0, 0, 1, 1, 1, 2, 2];
Nnodes = length(NodeType);

% __________                          __________    __________
% | Node 1 |                          | Node 4 |    | Node 6 |
% | Type 0 |->-\                 /-->-| Type 1 |-->-| Type 2 |
% ----------   |   __________    |    ----------    ----------
%              \-->| Node 3 |->--/
%              /-->| Type 1 |->--\
%              |   ----------    |    __________    __________
% __________   |                 \-->-| Node 5 |    | Node 7 |
% | Node 2 |->-/                      | Type 1 |-->-| Type 2 |
% | Type 0 |                          ----------    ----------
% ----------

node(1).Type = NodeType(1);
node(1).lambda = 500; % Means is a source node, packets generated per second
node(1).avgpcklen = 1000; % Average packet size (exponential distr.) in bits
node(1).out_bps = 0; % Means is a source node
node(1).qlen = 0; % Means is a source node
node(1).pcktsz = 0; % Means is a source node
node(1).NextServTime = 0; % Means is a source node
node(1).NextHop = 3; % The only output port from this source node will send to the node on the right of the equality
node(1).DestNode = 6*ones(1,M); % The destination node for packets generated at this node

node(2).Type = NodeType(2);
node(2).lambda = 500; % Means is a source node, packets generated per second
node(2).avgpcklen = 1000; % Average packet size (exponential distr.) in bits
node(2).out_bps = 0; % Means is a source node
node(2).qlen = 0; % Means is a source node
node(2).pcktsz = 0; % Means is a source node
node(2).NextServTime = 0; % Means is a source node
node(2).NextHop = 3; % The only output port from this source node will send to the node on the right of the equality
node(2).DestNode = 7*ones(1,M);  % The destination node for packets generated at this node

node(3).Type = NodeType(3);
node(3).lambda = 0; % Means that is not a source node
node(3).avgpcklen = 0; % Means that is not a source node
node(3).out_bps = 2000000; % Average out bit rate [bps]
node(3).qlen = zeros(1,M); % Queue length at each instant of time
node(3).pcktsz = zeros(1,M); % Packet size in queue
node(3).pcktserved = 0; % Arrival time slot of packet being served now
node(3).NextServTime = 0; % Next time a packet will be served
node(3).TimeInNode = zeros(1,M); % Measured in seconds
node(3).NextHop = [3 3 3 4 5 4 5]; % Routing table, each column is for a destination node and the entry is the next hop to reach destination
node(3).DestNode = zeros(1,M);

node(4).Type = NodeType(4);
node(4).lambda = 0; % Means that is not a source node
node(4).avgpcklen = 0; % Means that is not a source node

node(4).out_bps = 450e3; % Average out bit rate [bps]

node(4).qlen = zeros(1,M); % Queue length at each instant of time
node(4).pcktsz = zeros(1,M); % Packet size in queue
node(4).pcktserved = 0; % Arrival time slot of packet being served now
node(4).NextServTime = 0; % Next time a packet will be served
node(4).TimeInNode = zeros(1,M); % Measured in seconds
node(4).NextHop = [4 4 4 4 4 6 4]; % Routing table, each column is for a destination node and the entry is the next hop to reach destination
node(4).DestNode = zeros(1,M);

node(5).Type = NodeType(5);
node(5).lambda = 0; % Means that is not a source node
node(5).avgpcklen = 0; % Means that is not a source node
node(5).out_bps = 2000000; % Average out bit rate [bps]
node(5).qlen = zeros(1,M); % Queue length at each instant of time
node(5).pcktsz = zeros(1,M); % Packet size in queue
node(5).pcktserved = 0; % Arrival time slot of packet being served now
node(5).NextServTime = 0; % Next time a packet will be served
node(5).TimeInNode = zeros(1,M); % Measured in seconds
node(5).NextHop = [5 5 5 5 5 5 7]; % Routing table, each column is for a destination node and the entry is the next hop to reach destination
node(5).DestNode = zeros(1,M);

node(6).Type = NodeType(6);
node(6).lambda = 0; % Means that is not a source node
node(6).avgpcklen = 0; % Means that is not a source node
node(6).out_bps = 2000000; % Average out bit rate [bps]
node(6).qlen = zeros(1,M); % Queue length at each instant of time
node(6).pcktsz = zeros(1,M); % Packet size in queue
node(6).pcktserved = 0; % Arrival time slot of packet being served now
node(6).NextServTime = 0; % Next time a packet will be served
node(6).TimeInNode = zeros(1,M); % Measured in seconds
node(6).DestNode = zeros(1,M);

node(7).Type = NodeType(7);
node(7).lambda = 0; % Means that is not a source node
node(7).avgpcklen = 0; % Means that is not a source node
node(7).out_bps = 2000000; % Average out bit rate [bps]
node(7).qlen = zeros(1,M); % Queue length at each instant of time
node(7).pcktsz = zeros(1,M); % Packet size in queue
node(7).pcktserved = 0; % Arrival time slot of packet being served now
node(7).NextServTime = 0; % Next time a packet will be served
node(7).TimeInNode = zeros(1,M); % Measured in seconds
node(7).DestNode = zeros(1,M);

for i=2:M
    for k = 1:Nnodes
        if node(k).Type > 0
            node(k).qlen(i) = node(k).qlen(i-1);
        end
    end    
    for k = 1:Nnodes 
        switch node(k).Type
            case 0  % 0 = source node
                if rand < node(k).lambda*delta % probability of an arrival occurred = lambda * delta. See Leon-Garcia 12.3.1
                    NewPacketSize = ceil(exprnd(node(k).avgpcklen));
                    n = 0;
                    while node(node(k).NextHop).pcktsz(i+n) > 0
                        n = n + 1;
                    end    
                    node(node(k).NextHop).qlen(i) = node(node(k).NextHop).qlen(i) + 1;
                    node(node(k).NextHop).pcktsz(i+n) = NewPacketSize;
                    node(node(k).NextHop).DestNode(i+n) = node(k).DestNode(i); % Keep track where the packet is going to
                    if node(node(k).NextHop).NextServTime == 0 % Only if no packet is being served now
                        node(node(k).NextHop).pcktserved = i; % Stores the slot when the packet being served arrived
                        node(node(k).NextHop).NextServTime = i + n + ceil(( node(node(k).NextHop).pcktsz(i+n) / node(node(k).NextHop).out_bps)/delta);
                        node(node(k).NextHop).TimeInNode(i+n) =  delta*(node(node(k).NextHop).NextServTime - node(node(k).NextHop).pcktserved);
                    end
                end
            case 1   % 1 = routing node
                if node(k).NextServTime == i % packet is departing queue
                    % First work on the local queue
                    node(k).qlen(i) = node(k).qlen(i) - 1;
                    ExitPcktSize = node(k).pcktsz(node(k).pcktserved);  % Need to keep packet size for later
                    Dest = node(k).DestNode(node(k).pcktserved);  % Need to keep packet destination information for later
                    if node(k).qlen(i) > 0 % More packets remain in queue
                        % Stores the slot when the packet being to be served now arrived
                        node(k).pcktserved = node(k).pcktserved+min(find(node(k).pcktsz(node(k).pcktserved+1:end) > 0));
                        % Stores when the next packet will be served (depart queue)
                        node(k).NextServTime = i + ceil( (node(k).pcktsz(node(k).pcktserved) / node(k).out_bps)/delta);
                        node(k).TimeInNode(i) =  delta*(node(k).NextServTime - node(k).pcktserved);
                    else
                        node(k).NextServTime = 0;
                    end
                    % Next work on the queue receiving packet. Propagation delay is assumed equal to zero
                    n = 0;
                    while node(node(k).NextHop(Dest)).pcktsz(i+n) > 0
                        n = n + 1;
                    end                        
                    node(node(k).NextHop(Dest)).qlen(i) = node(node(k).NextHop(Dest)).qlen(i) + 1;
                    node(node(k).NextHop(Dest)).pcktsz(i+n) = ExitPcktSize;
                    node(node(k).NextHop(Dest)).DestNode(i+n) = Dest;
                    if node(node(k).NextHop(Dest)).NextServTime == 0 % Only if no packet is being served now
                        node(node(k).NextHop(Dest)).pcktserved = i; % Stores the slot when the packet being served arrived
                        node(node(k).NextHop(Dest)).NextServTime = i + n + ceil(( node(node(k).NextHop(Dest)).pcktsz(i) / node(node(k).NextHop(Dest)).out_bps)/delta);
                        node(node(k).NextHop(Dest)).TimeInNode(i) =  delta*(node(node(k).NextHop(Dest)).NextServTime - node(node(k).NextHop(Dest)).pcktserved);
                    end
                end
            case 2   % 2 = sink node
                if node(k).NextServTime == i % packet is departing queue
                    node(k).qlen(i) = node(k).qlen(i) - 1;
                    if node(k).qlen(i) > 0 % More packets remain in queue
                        % Stores the slot when the packet being to be served now arrived
                        node(k).pcktserved = node(k).pcktserved+min(find(node(k).pcktsz(node(k).pcktserved+1:end) > 0));
                        % Stores when the next packet will be served (depart queue)
                        node(k).NextServTime = i + ceil( (node(k).pcktsz(node(k).pcktserved) / node(k).out_bps)/delta);
                        node(k).TimeInNode(i) =  delta*(node(k).NextServTime - node(k).pcktserved);
                    else
                        node(k).NextServTime = 0;
                    end
                end
        end
    end
end    
 



timeinsys=node(4).TimeInNode(find(node(4).TimeInNode~=0));
mean(timeinsys)
mean(node(4).qlen)
plot(node(4).qlen);grid
