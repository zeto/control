module ProductsHelper
	def breadcrumb state
		states = state.product.transitions.map do |t| 
			"<li>" + (t.to == state ? "<h3>" + link_to_state(t.to) + "</h3>" : link_to_state(t.to)) + "</li>"
		end
		raw "<h2>Sequence:</h2><ol class='breadcrumb'>" + states.join(" ") + "</ol>"
	end
	
	private
	
	def link_to_state state
		"<a href=/" + state.class.to_s.underscore.pluralize + "/" + state.id.to_s + ">" + state.class.to_s + "</a>"	
	end
end
