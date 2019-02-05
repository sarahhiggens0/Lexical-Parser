# This class has all the token recognition logic. 
#Author: Sarah Higgens 

require_relative "Token"
class DotLexer
  
	def initialize
		@charClass = ""
		@readInNext = false
		@ID = 1
		@INT = 2
		@STRING = 3
		@LCURLY = 4
		@RCURLY = 5
		@SEMI = 6
		@LBRACK = 7
		@RBRACK = 8
		@ARROW = 9
		@EQUALS = 10
		@DIGRAPH = 11
		@SUBGRAPH = 12
		@COMMA = 13
		@WS = 14
		@EOF = 100
		@BADINPUT = 101
	end 
 
  # This method checks to see if the next token is already read in. 
	def checkIfRead 
		if(!@readInNext)
			@charClass = STDIN.getc
		else
			@readInNext = false
		end
	end 
  
  # This method decides if the lexeme is a id, digit or an operator. 
	def nextToken
		checkIfRead
		if( (@charClass =~ /[[:alpha:]]/))
			return id
		elsif( (@charClass =~ /[[:digit:]]/))
			return digit
		else
			lex 
		end
	end
  
  # This method determines if the operator is valid, not valid, or if 
  # the end of the file has been reached. If it is valid it determines
  # which token it belongs to.   
	def lex 
		case @charClass
			when '{'
				output = Token.new(@charClass, @LCURLY)
			when '}'
				output = Token.new(@charClass, @RCURLY)
			when ';'
				output = Token.new(@charClass, @SEMI)
			when '['
				output = Token.new(@charClass, @LBRACK)
			when ']'
				output = Token.new(@charClass, @RBRACK)
			when '-'
				output = arrow
			when '='
				output = Token.new(@charClass, @EQUALS)
			when ','
				output = Token.new(@charClass, @COMMA)
			when " ", "\n", "\t", "\r"
				nextToken
			when '"'
				output = letters
			when nil
				#puts "Lexical analysis is finished!"
				output = Token.new("", @EOF)
			else
				output = Token.new(@charClass, @BADINPUT)
			return output
		end
	end 
	
# This method reads in until the digit is done.
	def digit
		id = @charClass
		@charClass = STDIN.getc
		while((@charClass =~ /[[:digit:]]/))
		  id << @charClass
		  @charClass = STDIN.getc
		end
		output = Token.new(id, @INT)
		@readInNext = true
		return output
	end
  
  # This method reads in until it has reached an operator. Then it determines 
  # whether the id is a subgraph, diagraph, or a regular id. 
	def id
		id = @charClass
		@charClass = STDIN.getc
		while((@charClass =~ /[[:alpha:]]/) || (@charClass =~ /[[:digit:]]/))
			id << @charClass
			@charClass = STDIN.getc
		end
		@readInNext = true
		if(id == "SUBGRAPH" || id == "subgraph")
			output = Token.new(id, @SUBGRAPH)
		elsif(id == "DIGRAPH" || id == "digraph")
			output = Token.new(id, @DIGRAPH)
		else
			output = Token.new(id, @ID)
		end
    return output
  end
  
  # This method reads if it is an arrow. If it is not then it 
  # Has an invalid char. 
  def arrow
    id = @charClass
    @charClass = STDIN.getc
    if(@charClass == '>')
		id << @charClass
		output = Token.new(id, @ARROW)
	else 
		@readInNext = true
		output = Token.new(id, @BADINPUT)
    end
	return output
  end
end
 
  # This method reads in the rest of the string. 
  def letters
    id = @charClass
    @charClass = STDIN.getc
    while(@charClass != '"')
      id << @charClass
      @charClass = STDIN.getc
    end
    id << @charClass
    output = Token.new(id, @STRING)
	return output
  end
  


