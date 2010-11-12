xml.instruct!
xml.Response do
  xml.Say("Here's a list of your Senators and Representatives, select who you'd like to connect to.")
  xml.Gather(:action => "/dial", :numDigits => "1") do
    @members_of_congress.each_with_index do |member, index|
      xml.Say("Press #{index+1} for " + member.firstname + " " + member.lastname)
    end
  end
  xml.Redirect("/people")
end
