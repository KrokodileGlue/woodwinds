#include "ast.h"
#include "util.h"

struct StatementData statement_data[] = {
	{ STMT_FN_DEF,		"function definition"	},
	{ STMT_FOR_LOOP,	"for loop"		},
	{ STMT_IF_STMT,	"if"			},
	{ STMT_WHILE_LOOP,	"while loop"		},
	{ STMT_EXPR,		"expression"		},
	{ STMT_VAR_DECL,	"variable declaration"	},
	{ STMT_BLOCK,		"block"		},
	{ STMT_PRINT,		"print"		}
};

struct Expression *mkexpr(struct Token *tok)
{
	struct Expression *e = oak_malloc(sizeof *e);
	*e = (struct Expression){ tok, EXPR_INVALID, NULL, { { NULL, NULL, NULL } } };
	return e;
}

struct Statement *mkstmt(struct Token *tok)
{
	struct Statement *s = oak_malloc(sizeof *s);
	*s = (struct Statement){ tok, STMT_INVALID, { { NULL, NULL, NULL, NULL} } };
	return s;
}

void free_expr(struct Expression *e)
{
	if (e->type == EXPR_VALUE) {
		/* don't free the tokens here */
	} else {
		if (e->a) free_expr(e->a);
		if (e->b) free_expr(e->b);
		if (e->c) free_expr(e->c);
	}

	free(e);
}

void free_stmt(struct Statement *s)
{
	switch (s->type) {
	case STMT_EXPR:
		free_expr(s->expr);
		break;
	case STMT_BLOCK:
		for (size_t i = 0; i < s->block.num; i++) {
			free_stmt(s->block.stmts[i]);
		}

		free(s->block.stmts);

		break;
	case STMT_IF_STMT:
		free_expr(s->if_stmt.cond);
		free_stmt(s->if_stmt.then);
		if (s->if_stmt.otherwise)
			free_stmt(s->if_stmt.otherwise);
		break;
	case STMT_PRINT:
		for (size_t i = 0; i < s->print.num; i++) {
			free_expr(s->print.args[i]);
		}

		free(s->print.args);

		break;
	default:
		fprintf(stderr, "cannot free thing.\n");
	}

	free(s);
}

void free_ast(struct Statement **module)
{
	struct Statement *s = NULL;

	for (size_t i = 0; (s = module[i]); i++) {
		free_stmt(s);
	}

	free(module);
}
