if (document.addEventListener("DOMContentLoaded", function(t) { Vue.component("component-name", { template: TEMPLATE[""], props: ["dataSource", "endPoint"], methods: { sendForm: function(e) { t.preventDefault(), alert("...") } } }) }), void 0 === TEMPLATE) var TEMPLATE = {};
TEMPLATE[""] = '<div>\n\t\n\t<form @submit="sendForm">\n\n\t\t\x3c!-- interar form --\x3e\n\t\t<div v-for="i in dataSource">\n\t\t\t<div v-if="i.type == \'input\'">\n\t\t\t\t<label>{{ i.label }}</label>\n\t\t\t\t<input v-model="i.model" type="text">\t\n\t\t\t</div>\n\t\t\t<div v-if="i.type == \'checkbox\'">\n\t\t\t\t<label>{{ i.label }}</label>\n\t\t\t\t<input v-model="i.model"  type="checkbox">\t\n\t\t\t</div>\n\t\t\t<div v-if="i.type == \'select\'">\n\t\t\t\t<label>{{ i.label }}</label>\n\t\t\t\t<select v-model="i.model" >\n\t\t\t\t\t<option value="">12</option>\n\t\t\t\t</select>\t\n\t\t\t</div>\n\t\t</div>\n\n\t\t\x3c!-- botón  submit --\x3e\n\t\t<div>\n\t\t\t<input type="submit" value="enviar">\n\t\t</div>\n\n\t</form>\n\n\t\n\t\x3c!-- <pre>{{ dataSource | json }}</pre> --\x3e\n\n</div>';
//# sourceMappingURL=data:application/json;charset=utf8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm1haW4uanMiXSwibmFtZXMiOlsiZG9jdW1lbnQiLCJhZGRFdmVudExpc3RlbmVyIiwiZXZlbnQiLCJWdWUiLCJjb21wb25lbnQiLCJ0ZW1wbGF0ZSIsIlRFTVBMQVRFIiwicHJvcHMiLCJtZXRob2RzIiwic2VuZEZvcm0iLCJlIiwicHJldmVudERlZmF1bHQiLCJhbGVydCJdLCJtYXBwaW5ncyI6IkFBZ0JBLEdBZENBLFNBQVNDLGlCQUFpQixtQkFBb0IsU0FBU0MsR0FDdERDLElBQUlDLFVBQVUsa0JBQ2JDLFNBQVVDLFNBQVMsSUFDbkJDLE9BQVMsYUFBYyxZQUN2QkMsU0FDQ0MsU0FBVSxTQUFTQyxHQUNsQlIsRUFBTVMsaUJBQ05DLE1BQU0sa0JBT1ksSUFBYk4sU0FBMkIsSUFBSUEsWUFDekNBLFNBQVMsSUFBTSIsImZpbGUiOiJtYWluLmpzIiwic291cmNlc0NvbnRlbnQiOlsiKGZ1bmN0aW9uKCkge1xuXG5cdGRvY3VtZW50LmFkZEV2ZW50TGlzdGVuZXIoXCJET01Db250ZW50TG9hZGVkXCIsIGZ1bmN0aW9uKGV2ZW50KSB7XG5cdFx0VnVlLmNvbXBvbmVudCgnY29tcG9uZW50LW5hbWUnLCB7XG5cdFx0XHR0ZW1wbGF0ZTogVEVNUExBVEVbJyddLFxuXHRcdFx0cHJvcHM6IFsgJ2RhdGFTb3VyY2UnLCAnZW5kUG9pbnQnIF0sXG5cdFx0XHRtZXRob2RzOiB7XG5cdFx0XHRcdHNlbmRGb3JtOiBmdW5jdGlvbihlKSB7XG5cdFx0XHRcdFx0ZXZlbnQucHJldmVudERlZmF1bHQoKTtcblx0XHRcdFx0XHRhbGVydCgnLi4uJyk7XG5cdFx0XHRcdH1cblx0XHRcdH1cblx0XHR9KTtcblx0fSk7XG5cdFxufSkoKTtcbmlmKHR5cGVvZiBURU1QTEFURSA9PT0gJ3VuZGVmaW5lZCcpIHt2YXIgVEVNUExBVEUgPSB7fTt9XG5URU1QTEFURVsnJ10gPSBcIjxkaXY+XFxuXCIgK1xuICAgIFwiXHRcXG5cIiArXG4gICAgXCJcdDxmb3JtIEBzdWJtaXQ9XFxcInNlbmRGb3JtXFxcIj5cXG5cIiArXG4gICAgXCJcXG5cIiArXG4gICAgXCJcdFx0PCEtLSBpbnRlcmFyIGZvcm0gLS0+XFxuXCIgK1xuICAgIFwiXHRcdDxkaXYgdi1mb3I9XFxcImkgaW4gZGF0YVNvdXJjZVxcXCI+XFxuXCIgK1xuICAgIFwiXHRcdFx0PGRpdiB2LWlmPVxcXCJpLnR5cGUgPT0gJ2lucHV0J1xcXCI+XFxuXCIgK1xuICAgIFwiXHRcdFx0XHQ8bGFiZWw+e3sgaS5sYWJlbCB9fTwvbGFiZWw+XFxuXCIgK1xuICAgIFwiXHRcdFx0XHQ8aW5wdXQgdi1tb2RlbD1cXFwiaS5tb2RlbFxcXCIgdHlwZT1cXFwidGV4dFxcXCI+XHRcXG5cIiArXG4gICAgXCJcdFx0XHQ8L2Rpdj5cXG5cIiArXG4gICAgXCJcdFx0XHQ8ZGl2IHYtaWY9XFxcImkudHlwZSA9PSAnY2hlY2tib3gnXFxcIj5cXG5cIiArXG4gICAgXCJcdFx0XHRcdDxsYWJlbD57eyBpLmxhYmVsIH19PC9sYWJlbD5cXG5cIiArXG4gICAgXCJcdFx0XHRcdDxpbnB1dCB2LW1vZGVsPVxcXCJpLm1vZGVsXFxcIiAgdHlwZT1cXFwiY2hlY2tib3hcXFwiPlx0XFxuXCIgK1xuICAgIFwiXHRcdFx0PC9kaXY+XFxuXCIgK1xuICAgIFwiXHRcdFx0PGRpdiB2LWlmPVxcXCJpLnR5cGUgPT0gJ3NlbGVjdCdcXFwiPlxcblwiICtcbiAgICBcIlx0XHRcdFx0PGxhYmVsPnt7IGkubGFiZWwgfX08L2xhYmVsPlxcblwiICtcbiAgICBcIlx0XHRcdFx0PHNlbGVjdCB2LW1vZGVsPVxcXCJpLm1vZGVsXFxcIiA+XFxuXCIgK1xuICAgIFwiXHRcdFx0XHRcdDxvcHRpb24gdmFsdWU9XFxcIlxcXCI+MTI8L29wdGlvbj5cXG5cIiArXG4gICAgXCJcdFx0XHRcdDwvc2VsZWN0Plx0XFxuXCIgK1xuICAgIFwiXHRcdFx0PC9kaXY+XFxuXCIgK1xuICAgIFwiXHRcdDwvZGl2PlxcblwiICtcbiAgICBcIlxcblwiICtcbiAgICBcIlx0XHQ8IS0tIGJvdMOzbiAgc3VibWl0IC0tPlxcblwiICtcbiAgICBcIlx0XHQ8ZGl2PlxcblwiICtcbiAgICBcIlx0XHRcdDxpbnB1dCB0eXBlPVxcXCJzdWJtaXRcXFwiIHZhbHVlPVxcXCJlbnZpYXJcXFwiPlxcblwiICtcbiAgICBcIlx0XHQ8L2Rpdj5cXG5cIiArXG4gICAgXCJcXG5cIiArXG4gICAgXCJcdDwvZm9ybT5cXG5cIiArXG4gICAgXCJcXG5cIiArXG4gICAgXCJcdFxcblwiICtcbiAgICBcIlx0PCEtLSA8cHJlPnt7IGRhdGFTb3VyY2UgfCBqc29uIH19PC9wcmU+IC0tPlxcblwiICtcbiAgICBcIlxcblwiICtcbiAgICBcIjwvZGl2PlwiOyAiXX0=