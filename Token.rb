# This class that uses text and type to describe a token
#Author: Sarah Higgens 

class Token
	@@ILLEGAL = 101
	@@EOF = 100
	
# This is the constructor for the Token class. It initializes 
# the type and the text. 
	def initialize(text, type)
		@text = text
		@type = type
	end

 # This will print if a lexeme is legal or not. It will will also 
 # help print out all the tokens. 
	def to_s
		if(@type == @@ILLEGAL)
			output =  "illegal char: " + @text
		else 
			output = "[" + @text + ":" + @type.to_s + "]"
		end
		return output
	end 
  
# This method allows Prog3 to see what EOF is. 
	def self.EOF
		return @@EOF
	end

	# This is a getter method for type. 
	def type
		return @type
	end
end
