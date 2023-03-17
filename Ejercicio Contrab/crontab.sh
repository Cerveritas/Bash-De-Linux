#!/bin/bash


0 8 * * 0 echo Ejecutada > /tmp/mondays.txt
0 12 1 * * echo Ejecutada > /tmp/monthly.txt
0 16 1 1 * echo Ejecutada > /tmp/yearly.txt
*/5 * * * * echo Ejecutada > /tmp/fiveminutes.txt
15 */1 * * * echo Ejecutada > /tmp/15minute.txt
30 19 * * 0-7 echo Ejecutada > /tmp/wekkdays.txt



