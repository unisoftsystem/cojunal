if (typeof TEMPLATE === 'undefined') { var TEMPLATE = {}; }
TEMPLATE[''] = "<div>\n" +
    "	\n" +
    "	<form @submit=\"sendForm\">\n" +
    "\n" +
    "		<!-- interar form -->\n" +
    "		<div v-for=\"i in dataSource\">\n" +
    "			<div v-if=\"i.type == 'input'\">\n" +
    "				<label>{{ i.label }}</label>\n" +
    "				<input v-model=\"i.model\" type=\"text\">	\n" +
    "			</div>\n" +
    "			<div v-if=\"i.type == 'checkbox'\">\n" +
    "				<label>{{ i.label }}</label>\n" +
    "				<input v-model=\"i.model\"  type=\"checkbox\">	\n" +
    "			</div>\n" +
    "			<div v-if=\"i.type == 'select'\">\n" +
    "				<label>{{ i.label }}</label>\n" +
    "				<select v-model=\"i.model\" >\n" +
    "					<option value=\"\">12</option>\n" +
    "				</select>	\n" +
    "			</div>\n" +
    "		</div>\n" +
    "\n" +
    "		<!-- botón  submit -->\n" +
    "		<div>\n" +
    "			<input type=\"submit\" value=\"enviar\">\n" +
    "		</div>\n" +
    "\n" +
    "	</form>\n" +
    "\n" +
    "	\n" +
    "	<!-- <pre>{{ dataSource | json }}</pre> -->\n" +
    "\n" +
    "</div>";