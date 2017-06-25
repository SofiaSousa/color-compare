# module ColorCompare
	class DeltaECIE

		def self.calculate(first_color, second_color)
			first_color  = CIELab.new(first_color.to_cielab)
			second_color = CIELab.new(second_color.to_cielab)

			l1, a1, b1 = first_color.to_array
			l2, a2, b2 = second_color.to_array

			l = (l1 - l2) ** 2
			a = (a1 - a2) ** 2
			b = (b1 - b2) ** 2

			distance = Math.sqrt(l + a + b) / Math.sqrt(1 ** 2 +  256 ** 2 + 256 ** 2)
	end
end