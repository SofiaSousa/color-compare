# module SSGenerator
	# module Helpers 
		class Float 
			# round down
			def m_floor(exp = 0)
				multiplier = 10 ** exp
	      ((self * multiplier).floor).to_f / multiplier.to_f
	    end

	    # round up
	    def m_ceil(exp = 0)
	  	  multiplier = 10 ** exp
	      ((self * multiplier).ceil).to_f / multiplier.to_f
	    end
    end
	# end
# end