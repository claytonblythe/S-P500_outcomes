# S&P 500 Investment Outcomes

A repository for investigating the historical distribution of investment outcomes since 1871

Hello, my name is Clayton Blythe and this is a program to investigate what are the investment outcomes that one can expect from the S&P500 based on historical data. Though past performance is not certain, it gives an interesting visualization and calculation of ballpark estimates (barring any serious unforseen event).

Notes: Values are adjusted for inflation, assuming yearly reinvestment of that year's dividends. For every time horizon (1 month -> 480 months) I calculated the distribution of cash multipliers that one can expect. The cash multiplier is defined as what value you can expect a $1 initial investment to eventually grow to be. 

Data includes from 1871 to 1976, as 40 year outcomes were not available since then. I am working on including more recent data for the shorter time horizons, as those should be available. 

Language: R (R-Studio)

Here is the final product, showing the density of investing outcomes over a progressingly longer investing time horizon.
# Densities of Investment Outcomes:
![Alt Test](https://github.com/claytonblythe/S-P500_outcomes/blob/figures/40years.png)

# Outcome Distributions for Various Time Horizons:
![Alt Test](https://github.com/claytonblythe/S-P500_outcomes/blob/figures/investments_final.gif)

# Investment Outcome Heatmaps:
![Alt Test](https://github.com/claytonblythe/S-P500_outcomes/blob/figures/cashmultipliers_Spectral_20years.png)

