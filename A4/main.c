
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "main.h"
#include "lcd_drv.c"

#include <avr/io.h>
#include <stdbool.h>
#include <avr/interrupt.h>

int sec = 0;
int min = 0;
int hr = 0; 
char*msg;

bool pause = false;

int disVal = 0;		
unsigned int val;	// Low value 
unsigned int val2;	// High value 
	


ISR(TIMER1_OVF_vect)
{

TCNT1=0xC2F6;

	sec++;

	if(sec>59)
	{
		sec = 0;
		min++;
	}

	if(min>59)
	{
		min = 0;
		hr++;
	}

	if(hr>24)

	{
		hr = 0;
	}

	sprintf(msg, "%02i:%02i:%02i", hr ,min, sec);

}


ISR(TIMER0_OVF_vect)
{
	
TCNT0=0xD000;

		ADCSRA = ADCSRA | 0x40;

		while (ADCSRA & 0x40)
		{
		
		}

		val = ADCL;
		val2 = ADCH;

		val += (val2 << 8);
	
		if (val < 1000)
		{		 
		   if (pause == false)
		   {
		    	pause = true;
		   } 

		   else
	 	   {
		        pause = false;
	 	   }
		}
} 


void initButton ()
{	
	ADCSRA = 0x87;
	ADMUX = 0x40;
}


int main( void )
{

	msg = "00:00:00";

	initButton();

	TIMSK0 |=(1<<TOIE0);
    TIMSK1 |=(1<<TOIE1);
	
	TCNT0=0xD000;
  
	TCNT1=0xC2F6;

	TCCR0B = (1<<CS02) | (1<<CS00);

	TCCR1B = (1 << CS10) | (1 << CS12);
	
	sei(); 


	lcd_init();

	while(true) 
	{
		lcd_xy( 0, 0 );
		lcd_puts(msg);

		if (pause == false)
		{
			lcd_xy(0,1);
			lcd_puts(msg);
		}
	} 
} 
