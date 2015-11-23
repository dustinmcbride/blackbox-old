Thread.new do

while true == true
  a = Time.now
    s = Setting.where(:use => true).first
      if s.update_in_bg == true


        #get nearest plane
        Airplane.refresh
        a = Airplane.where(:is_inview => true).order('range').first

        # write fligts in view to db


        # lookup flights in view with flight numbers on flight aware

        # write airplane message to lcd
        if a == nil
          system "sudo python ./vendor/python/writetolcd.py \"No planes in sight\" \" NA \" "
        elsif
          msg = a.getlcdmessage
          system "sudo python ./vendor/python/writetolcd.py \"#{msg[0]}\" \"R:#{msg[1]}\""
        end


    #sleep 0
    b = Time.now
    runtime = b - a
    logger.debug "-----------------------#{runtime}-----------------------"
  end
  end

end
