// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import TomSelect from "tom-select"

import { Tab, initMDB } from "mdb-ui-kit";

initMDB({ Tab });

window.bootstrap = bootstrap
window.TomSelect = TomSelect

// document.addEventListener("DOMContentLoaded", function(){
//     new TomSelect("#section_course_id",{
//         create: false,
//         sortField: {
//             field: "text",
//             direction: "asc"
//         }
//     });
//     new TomSelect("#section_teacher_id",{
//         create: false,
//         sortField: {
//             field: "text",
//             direction: "asc"
//         }
//     });
// });
