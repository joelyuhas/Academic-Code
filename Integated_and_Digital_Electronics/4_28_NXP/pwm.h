#ifndef PWM_H_
#define PWM_H_

void SetDutyCycle(unsigned int DutyCycle, unsigned int Frequency, int dir, unsigned int rightWheelPw, unsigned int leftWheelPw);
void SetDervoDutyCycle(double DutyCycle, unsigned int Frequency);
void InitPWM(void);
void PWM_ISR(void);

#endif /* PWM_H_ */
