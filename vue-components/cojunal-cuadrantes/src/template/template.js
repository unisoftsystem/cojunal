if(typeof TEMPLATE === 'undefined') {var TEMPLATE = {};}
TEMPLATE[''] = "<div id=\"cojunal-cuarantes\">\n" +
    "\n" +
    "	<div v-if=\"verified(cuadrantes.deudores_mora_30[0].total)\">\n" +
    "\n" +
    "		<!-- row con los cuadrantes -->\n" +
    "		<div class=\"b-row\">\n" +
    "\n" +
    "			<div class=\"b-col xs-12 md-6\">\n" +
    "				<div class=\"b-cuadrante b-yellow b-rigth\">\n" +
    "					<a href=\"http://cojunal.com/plataforma/beta/admin/RangeDeudoresMora/1?page=1\" class=\"b-container\">\n" +
    "						<span class=\"b-number\">1</span>\n" +
    "						<div class=\"b-divisor\"></div>\n" +
    "						<div class=\"b-info\">\n" +
    "							<div class=\"b-valor b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Valor\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									$ {{ parseFloat(cuadrantes.deudores_mora_30[0].total || 0).format(0, 0, '.') }}\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-tiempo-mora b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Tiempo de mora\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									30 dias\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-row\"></div>\n" +
    "						</div>\n" +
    "					</a>\n" +
    "				</div>\n" +
    "			</div>\n" +
    "\n" +
    "			<div class=\"b-col xs-12 md-6\">\n" +
    "				<div class=\"b-cuadrante b-dark-blue b-left\">\n" +
    "					<a href=\"http://cojunal.com/plataforma/beta/admin/RangeDeudoresMora/2?page=1\" class=\"b-container\">\n" +
    "						<span class=\"b-number\">2</span>\n" +
    "						<div class=\"b-divisor\"></div>\n" +
    "						<div class=\"b-info\">\n" +
    "							<div class=\"b-valor b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Valor\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									$ {{ parseFloat(cuadrantes.deudores_mora_30_60[0].total || 0).format(0, 0, '.') }}\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-tiempo-mora b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Tiempo de mora\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									31-60 dias\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-row\"></div>\n" +
    "						</div>\n" +
    "					</a>\n" +
    "				</div>\n" +
    "			</div>\n" +
    "\n" +
    "		</div>\n" +
    "\n" +
    "		<!-- separador de columnas  -->\n" +
    "		<div class=\"b-separator b-clear\"></div>\n" +
    "\n" +
    "		<!-- row con los cuadrantes -->\n" +
    "		<div class=\"b-row\">\n" +
    "\n" +
    "			<div class=\"b-col xs-12 md-6\">\n" +
    "				<div class=\"b-cuadrante b-blue b-rigth\">\n" +
    "					<a href=\"http://cojunal.com/plataforma/beta/admin/RangeDeudoresMora/3?page=1\" class=\"b-container\">\n" +
    "						<span class=\"b-number\">3</span>\n" +
    "						<div class=\"b-divisor\"></div>\n" +
    "						<div class=\"b-info\">\n" +
    "							<div class=\"b-valor b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Valor\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									$ {{ parseFloat(cuadrantes.deudores_mora_61_90[0].total || 0).format(0, 0, '.') }}\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-tiempo-mora b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Tiempo de mora\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									61-90 dias\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-row\"></div>\n" +
    "						</div>\n" +
    "					</a>\n" +
    "				</div>\n" +
    "			</div>\n" +
    "\n" +
    "			<div class=\"b-col xs-12 md-6\">\n" +
    "				<div class=\"b-cuadrante b-green b-left\">\n" +
    "					<a href=\"http://cojunal.com/plataforma/beta/admin/RangeDeudoresMora/4?page=1\" class=\"b-container\">\n" +
    "						<span class=\"b-number\">4</span>\n" +
    "						<div class=\"b-divisor\"></div>\n" +
    "						<div class=\"b-info\">\n" +
    "							<div class=\"b-valor b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Valor\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									$ {{ parseFloat(cuadrantes.deudores_mora_91_120[0].total || 0).format(0, 0, '.') }}\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-tiempo-mora b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Tiempo de mora\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									91-120 dias\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-row\"></div>\n" +
    "						</div>\n" +
    "					</a>\n" +
    "				</div>\n" +
    "			</div>\n" +
    "\n" +
    "		</div>\n" +
    "\n" +
    "		<!-- separador de columnas  -->\n" +
    "		<div class=\"b-separator b-clear\"></div>\n" +
    "\n" +
    "		<!-- row con los cuadrantes -->\n" +
    "		<div class=\"b-row\">\n" +
    "\n" +
    "			<div class=\"b-col xs-12 md-6\">\n" +
    "				<div class=\"b-cuadrante b-yellow b-rigth\">\n" +
    "					<a href=\"http://cojunal.com/plataforma/beta/admin/RangeDeudoresMora/5?page=1\" class=\"b-container\">\n" +
    "						<span class=\"b-number\">5</span>\n" +
    "						<div class=\"b-divisor\"></div>\n" +
    "						<div class=\"b-info\">\n" +
    "							<div class=\"b-valor b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Valor\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									$ {{ parseFloat(cuadrantes.deudores_mora_121_180[0].total || 0).format(0, 0, '.') }}\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-tiempo-mora b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Tiempo de mora\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									121-180 dias\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-row\"></div>\n" +
    "						</div>\n" +
    "					</a>\n" +
    "				</div>\n" +
    "			</div>\n" +
    "\n" +
    "			<div class=\"b-col xs-12 md-6\">\n" +
    "				<div class=\"b-cuadrante b-dark-blue b-left\">\n" +
    "					<a href=\"http://cojunal.com/plataforma/beta/admin/RangeDeudoresMora/6?page=1\" class=\"b-container\">\n" +
    "						<span class=\"b-number\">6</span>\n" +
    "						<div class=\"b-divisor\"></div>\n" +
    "						<div class=\"b-info\">\n" +
    "							<div class=\"b-valor b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Valor\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									$ {{ parseFloat(cuadrantes.deudores_mora_181_360[0].total || 0).format(0, 0, '.') }}\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-tiempo-mora b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Tiempo de mora\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									181-360 dias\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-row\"></div>\n" +
    "						</div>\n" +
    "					</a>\n" +
    "				</div>\n" +
    "			</div>\n" +
    "\n" +
    "		</div>\n" +
    "\n" +
    "		<!-- separador de columnas  -->\n" +
    "		<div class=\"b-separator b-clear\"></div>\n" +
    "\n" +
    "		<!-- row con los cuadrantes -->\n" +
    "		<div class=\"b-row\">\n" +
    "\n" +
    "			<div class=\"b-col xs-12 md-6\">\n" +
    "				<div class=\"b-cuadrante b-blue b-rigth\">\n" +
    "					<a href=\"http://cojunal.com/plataforma/beta/admin/RangeDeudoresMora/7?page=1\" class=\"b-container\">\n" +
    "						<span class=\"b-number\">7</span>\n" +
    "						<div class=\"b-divisor\"></div>\n" +
    "						<div class=\"b-info\">\n" +
    "							<div class=\"b-valor b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Valor\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									$ {{ parseFloat(cuadrantes.deudores_mora_360[0].total || 0).format(0, 0, '.') }}\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-tiempo-mora b-row\">\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									Tiempo de mora\n" +
    "								</div>\n" +
    "								<div class=\"b-col md-6\">\n" +
    "									más de 361 dias\n" +
    "								</div>\n" +
    "							</div>\n" +
    "							<div class=\"b-row\"></div>\n" +
    "						</div>\n" +
    "					</a>\n" +
    "				</div>\n" +
    "			</div>\n" +
    "\n" +
    "		</div>\n" +
    "\n" +
    "	</div>\n" +
    "\n" +
    "\n" +
    "</div>\n" +
    ""; 