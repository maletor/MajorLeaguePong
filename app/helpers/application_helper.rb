module ApplicationHelper

  def fucking_advice
    ["Fucking ideate.", "Use more fucking white space.", "Fucking start over.", "Read the fucking copy.", "Capitalize on the fucking experience", "Use fucking alignment.", "Less if fucking more.", "Learn from your fucking mistakes", "There is no fucking box.", "Pay attention to fucking detail.", "Think fucking laterally.", "Quit your fucking job.", "Write a fucking design brief.", "Consider your fucking user.", "Fucking do it again.", "Sans-fucking-serif.", "Fucking experiement.", "Get over your fucking self.", "Work outside of your fucking habits.", "Do it right the first fucking time.", "Give a damn.", "Learn from your fucking peers.", "Love your job.", "Fucking simplify.", "Take a fucking chance.", "Educate your client.", "Be a good fucking person.", "Don't be trendy", "Have a clear fucking hierarchy"]
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, { :sort => column, :direction => direction } 
  end
end
