Thread.new do

while true == true
    s = Setting.where(:use => true).first
    if s.update_in_bg == true
    Airplane.refresh
    #get nearest plane
    a = Airplane.where(:is_inview => true).order('range').first
    # write fligts in view to db
    # lookup flights in view with flight numbers on flight aware
    # write airplane to lcd

    if a == nil
      system "sudo python ./vendor/python/writetolcd.py \"No planes in sight\" \"NA\""
    elsif
      system "sudo python ./vendor/python/writetolcd.py \"#{a.hex} A:#{a.altitude}\" \"R:#{a.range.round(1)} S:#{a.speed}\""
    end

    sleep 1
  end
  end

end
