class CalculatorController < ApplicationController
  def index
  end

  def add
    numbers = params[:numbers]
    @sum = calculate_sum(numbers)
    render :index
  rescue StandardError => e
    @error_message = e.message
    render :index, status: :bad_request
  end

  private

  def calculate_sum(numbers)
  	if numbers.match?('-')
  		numbers = numbers.gsub("\"", "" ).split(',').map(&:to_i)
  	else
	  	numbers = numbers.scan(/\d+/).map(&:to_i)
	  end
	  sum = 0
	  negatives = []  
    numbers.each do |num|
      if num < 0
        negatives << num
      else
        sum += num
      end
    end
    raise "Negative numbers not allowed: #{negatives.join(',')}" if negatives.any?
    sum
  end
end
