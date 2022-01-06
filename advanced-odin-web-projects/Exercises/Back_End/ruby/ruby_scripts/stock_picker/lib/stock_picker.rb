# frozen_string_literal: true

def stock_picker(prices)
  profit = 0
  prices.size > 1 ? buy_sell = [0, 1] : nil
  prices.each_with_index do |price, idx|
    # For each 'price' find the difference from the 'price' at the following index, up to the 2nd last 'price'
    # (stops at the last day)
    day = idx + 1
    while day < (prices.size)
      # If difference is greater than standing profit, update profit to difference and set idx/day as the buy/sell dates
      if (prices[day] - price) > profit
        buy_sell = [idx, day]
        profit = prices[day] - price
      end
      day += 1
    end
  end
  buy_sell
end
