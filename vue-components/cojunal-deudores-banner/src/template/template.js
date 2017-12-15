if(typeof cojunalDeudoresBannerTemplate === 'undefined') {var cojunalDeudoresBannerTemplate = {};}
cojunalDeudoresBannerTemplate[''] = "<div id=\"deudores-banner\">\n" +
    "	\n" +
    "	<div>\n" +
    "		\n" +
    "		<div class=\"b-col b-col-60\">\n" +
    "			\n" +
    "			<div class=\"b-title-container\">\n" +
    "				<span class=\"b-title\">DEUDORES</span>\n" +
    "				<span class=\"b-separator\"></span>\n" +
    "				<div class=\"b-valor\">Valor unidad: <b>FALTA</b></div>\n" +
    "				<div class=\"b-deudores\">Número de deudores: {{ parseFloat(data.cantidad_deudores).format(0, 0, '.') }}</div>\n" +
    "			</div>\n" +
    "\n" +
    "		</div>\n" +
    "\n" +
    "		<div class=\"b-col b-col-40\">\n" +
    "			<div class=\"b-detail\">\n" +
    "				<div class=\"b-percentage\">\n" +
    "					<b>Porcentaje de recuperacion total:</b> <span>{{ parseFloat(data.porcentaje_recuperacion).format(0, 2, '.') }}</span>\n" +
    "				</div>\n" +
    "				<br>\n" +
    "				<div class=\"b-link\">\n" +
    "					<a href=\"#\">\n" +
    "						Ver toda la lista \n" +
    "						<i class=\"fa fa-long-arrow-right\" aria-hidden=\"true\"></i>\n" +
    "					</a>\n" +
    "				</div>\n" +
    "			</div>\n" +
    "		</div>\n" +
    "			\n" +
    "		<div class=\"b-clear\"></div>\n" +
    "\n" +
    "	</div>\n" +
    "\n" +
    "</div>"; 