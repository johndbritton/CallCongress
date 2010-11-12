xml.instruct!
xml.Response do
  xml.Say("Please wait while we connect you to " + @member.firstname + " " + @member.lastname)
  xml.Dial(@member.phone)
  xml.Hangup
end
