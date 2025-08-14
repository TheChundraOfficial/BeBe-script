module lexer.tokens;

enum TokenType {
	PRINT,
	PRINTLN,
	NEWLINE,
	STRING,

	UNKNOWN,
	EOF
};

class Token {
	TokenType type;
	size_t pos;
	string value;

	this(string value, TokenType type, size_t pos) {
		this.type = type;
		this.pos = pos;
		this.value = value;
	}
};
