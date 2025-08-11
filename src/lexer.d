module lexer.lexer;


import std.stdio;
import std.range;
import std.string;

import lexer.tokens;


Token CreateNewToken(string value, size_t pos) {
	TokenType type;

	if(value == "BEBEBE")		type = TokenType.PRINT;
	else if(value == "Ebe")     type = TokenType.NEWLINE;
	else {
		if(value[0] == '^') {
			type = TokenType.STRING;
			value.popFront();
		}
		else {
			type = TokenType.UNKNOWN;
		}
	}

	auto NewToken = new Token(value, type, pos);
	return NewToken;
}

Token[] lex(string source) {
	Token[] tokens;
	string token;
	size_t pos;


	while(pos < source.length) {
		if(source[pos] == '.' || source[pos] == '\n' || source[pos] == '\t') {
			tokens ~= CreateNewToken(token,  pos);
			token = "";
			++pos;
			
			continue;
		}

		else if(source[pos] == '^') {
			if(!token.empty) {
				tokens ~= CreateNewToken(token, pos);
				token = "";
			}

			while(source[pos] != '.' && pos < source.length) {
				token ~= source[pos];
				++pos;
			} ++pos;
			tokens ~= CreateNewToken(token, pos);
			token = "";

			continue;
		}

		else {
			token ~= source[pos];
			++pos;
		}
	}

	if(!token.empty) {
		tokens ~= CreateNewToken(token, pos);
	}

	return tokens;
}

void print(Token[] tokens) {
	foreach(token; tokens) {
		writefln("value: %s, pos: %s, type: %s", token.value, token.pos, token.type);
	}
}

void main() {
	string source = "BEBEBE^Hello, world!.Ebe";

	Token[] tokens = lex(source);
	print(tokens);
}
