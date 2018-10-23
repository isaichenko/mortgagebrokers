module BorrowerRequestsHelper
  def get_languages lang 
    lang.reject { |e| e.to_s.empty? }.join(",")
  end 
  def get_areas areas 
    broker_areas = []
    areas.each {|area| broker_areas << area["city"]}
    broker_areas.join(",")
  end 
  def score_value score 
    if score >=300 and score <= 499
      return 'Very Poor'
    elsif score >=500 and score <= 574
      return 'Poor'     
    elsif score >=575 and score <= 649
      return 'Fair'
    elsif score >=650 and score <= 749
      return 'Good'
    else
      return 'Excellent'
    end                   
  end
  def get_bidding_hours bidding_end_time
    time_diff = bidding_end_time - Time.now    
    if time_diff > 0
     seconds_diff = time_diff.to_i.abs

      hours = seconds_diff / 3600
      seconds_diff -= hours * 3600

      minutes = seconds_diff / 60
      seconds_diff -= minutes * 60

      seconds = seconds_diff

      return "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
    end 
  end  
  def cap_status status   
    return status = (status.to_s == 'publish' ? 'Published/Active' : ( status.to_s == 'expire' ?  'Expired' : status.to_s.capitalize))
  end 
  def get_bid_position bids , rate 
    return bids.pluck(:rate).find_index(rate) + 1
  end 
  def is_active_filter(filter_name, class_name = nil)
      if params[:filter] == filter_name
          class_name == nil ? "active" : class_name
      else
          nil
      end
  end   
end
