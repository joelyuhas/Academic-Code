#--------------------------------------------------------------------------------
# Stocks
#--------------------------------------------------------------------------------
# Gets the live stock values from yahoo. does some algorithims too
# March 4 - 2020
# Joel Yuhas
#--------------------------------------------------------------------------------




#import urllib.request
#import urllib.parse
#import re
import bs4
import math
import requests
import datetime
import time
import sys
from bs4 import BeautifulSoup
from urllib.request import urlopen


### URLS
GASX_url = 'https://finance.yahoo.com/quote/GASX?p=GASX&.tsrc=fin-srch'
GASL_url = 'https://finance.yahoo.com/quote/GASL?p=GASL&.tsrc=fin-srch'
SPXS_url = 'https://finance.yahoo.com/quote/SPXS/'
SPXL_url = 'https://finance.yahoo.com/quote/spxl?ltr=1'



PERCENT_AWAY = 0.01


MONEY = 20000


### Stock Class
class Stock:
    def __init__(self, name, url, quantity, buy_price, peak):
        self.name = name
        self.url = url
        self.quantity = quantity
        self.buy_price = buy_price
        self.peak = peak
    
    def updatePrice(self):
        try:
            page = urlopen(self.url)
            soup=BeautifulSoup(page,'html.parser')
            soup.find_all('div',{'class': 'My(6px) Pos(r) smartphone_Mt(6px)'})
            final = float(soup.find('div',{'class': 'My(6px) Pos(r) smartphone_Mt(6px)'}).find('span').text)
        except:
            print("Website not responsive!")
            final=self.peak
        
        return(final)



## STOCK INITIALIZATION
GASX = Stock("GASX", GASX_url, 0, 0, 0 )
GASL = Stock("GASL", GASL_url, 0, 0, 0 )
SPXS = Stock("SPXS", SPXS_url, 0, 0, 0 )
SPXL = Stock("SPXL", SPXL_url, 0, 0, 0 )

Stock_List = [GASX,GASL,SPXS,SPXL]


    
def sell(stock):
    global MONEY
    current_price = stock.updatePrice()
    MONEY = MONEY + stock.quantity*current_price
    file = open(stock.name +"1.txt","w+")
    file.write("SALE!\n")
    file.write("\n")
    file.write("Item          : " + str(stock.name) + '\n')
    file.write("Item          : " + str(stock.url) + '\n')
    file.write("Date and time : " + str(datetime.datetime.now()) + '\n')
    file.write("Quantity      : " + str(stock.quantity) + '\n')
    file.write("Price Sold    : " + str(current_price)+ '\n')
    file.write("Buy Price     : " + str(stock.buy_price)+ '\n')
    file.write("Value         : " + str(current_price * stock.quantity)+ '\n')
    file.write("Bankroll      : " + str(MONEY)+ '\n')
    file.close()
    
    
    print("Selling! : " + stock.name + "  PRICE: " + str(current_price) + " QUANTITY : " + str(stock.quantity) + "  VALUE : " + str(stock.quantity*current_price) + " MONEY : " + str(MONEY))
    print("\n\n")
    stock.quantity=0


def buy(stock, dollar_amount):
    global MONEY
    current_price = stock.updatePrice()
    stock.quantity = math.floor(dollar_amount/current_price)
    stock.buy_price = current_price
    #stock.peak = current_price
    print("")
    print("BUY!      " + str(stock.name))
    print("current_price: " + str(current_price))
    print("dollar_amount: " + str(dollar_amount))
    print("quantity: " + str(stock.quantity))
    print("value: " + str(current_price*stock.quantity))
    print("")
    MONEY = MONEY - (current_price*stock.quantity)

  


def update(stock):
    if stock.quantity > 0:
        current_price = stock.updatePrice()
        if current_price <= (stock.peak - stock.peak*PERCENT_AWAY):
            sell(stock)
        elif current_price > stock.peak:
            stock.peak = current_price





def main():
    i = 1
    trigger = 0
    
    while i > 0:
        if trigger == 0:
            t = datetime.datetime.today()
            if t.hour == 9:
                if MONEY > 1000:

                    for stock in Stock_List:
                        buy(stock, 5000)
                      
                if t.minute >= 45:
                    print("Setting Peak\n\n")

                    for stock in Stock_List:
                        stock.peak = stock.updatePrice()
                        
                    trigger = 1
            time.sleep(1)       
        else:   
            for stock in Stock_List:
                update(stock)
                updated_price = stock.updatePrice()
                
                sys.stdout.write(str(stock.name) + " PEAK: " + str(stock.peak) + "  PRICE: " + str(updated_price) + " QUANTITY : " + str(stock.quantity) + "  VALUE : " + str(updated_price*stock.quantity) + " BANK : " + str(MONEY))
                sys.stdout.flush()
                sys.stdout.write('\b')
                sys.stdout.write('\r')
                
                time.sleep(1)
            
            if t.hour == 15:
                if t.minute >= 50:
                    print("Final Call\n\n")

                    for stock in Stock_List:
                        sell(stock)
                    
                    i = -1




main()
print("Finsihed!")
   
