Thread.new do
running = 0
while true == true
  starttime = Time.now
  puts "1"
    s = Setting.where(:use => true).first
  puts "2"
      if s.update_in_bg == true
  puts "3"
        #get nearest plane
          Airplane.refresh
        a = Airplane.where(:is_inview => true).order('range').first

        # write fligts in view to db


        # lookup flights in view with flight numbers on flight aware

        # write airplane message to lcd
        if a == nil
          system "sudo python ./vendor/python/writetolcd.py \"No planes\" \"Loop Run: #{running} \" "
        elsif
          msg = a.getlcdmessage
          system "sudo python ./vendor/python/writetolcd.py \"#{msg[0]}\" \"R:#{msg[1]}\""#        end
      end

    #sleep 0
    puts "4"

  end
  endtime = Time.now
  running = endtime - starttime
  puts "----------------------------------------------"
  puts running
  puts "----------------------------------------------"
  #logger.debug "This is from debug"
  end



end
