# S&P 500 Investment Outcomes

This is a project I have begun  for investigating the historical distribution of investment outcomes since 1871.

Hello, my name is Clayton Blythe and this is a program to investigate what are the investment outcomes that one can expect from the S&P500 based on historical data. Though past performance is not certain, it gives an interesting visualization and calculation of ballpark estimates (barring any serious unforseen event).

I am interested in investigating the probability distribution, variance, and expected value that one can expect of investment in the general U.S. Stock Market over various time horizons.  

Notes: Values are adjusted for inflation, assuming yearly reinvestment of that year's dividends. For every time horizon (1 month -> 480 months) I calculated the distribution of cash multipliers that one can expect. The cash multiplier is defined as what value you can expect a $1 initial investment to eventually grow to be. This is useful, as it can serve as a simple multiplier for estimating returns for various purposes such as retirement savings.

Data includes from 1871 to 2016, where 40 year outcomes are not availble before 1976. This can be seen with the trapezoidal heat map below. 
I have calculated investment outcomes in the investments.R file, with plots made using ggplot for nice visualization. 

Language: R (R-Studio)

Here is the final product, showing the density of investing outcomes over a progressingly longer investing time horizon.
# Densities of Investment Outcomes:
![Alt Test](https://github.com/claytonblythe/S-P500_outcomes/blob/figures/40years.png)

# Outcome Distributions for Various Time Horizons:
![Alt Test](https://github.com/claytonblythe/S-P500_outcomes/blob/figures/investments_final.gif)

# Investment Outcome Heatmaps:

# 20 year heatmap
![Alt Test](https://github.com/claytonblythe/S-P500_outcomes/blob/figures/cashmultipliers_Spectral_20years.png)

# 40 year heatmap
![Alt Test](https://github.com/claytonblythe/S-P500_outcomes/blob/figures/cashmultipliers_Spectral_40years.png)

