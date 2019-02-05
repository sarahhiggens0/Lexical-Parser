# This is the main class for program4, which was provided by the instructor.
# Author:: Joshua Yue

require_relative "DotLexer"
require_relative "DotParser"

# Uncomment this line for debugging. Must place Prog4_1.in with desired input
# in the lib folder of the project.
#$stdin.reopen("Prog4_1.in")

lexer = DotLexer.new

parser = DotParser.new(lexer)

parser.graph()


