library(shiny)
library(reticulate)
library(DT)
library(plotly)
library(gridlayout)
library(bslib)

use_condaenv("shinyEMG", required = TRUE)
sys = import("sys",convert = FALSE)
sys <- reticulate::import("sys", convert = FALSE)
sys$path$append("/home/ohta/Atlas/python/tools") 
setwd("/home/ohta/Atlas/python/tools")
sckfda = import("skfda")
sb = import("seaborn")
np = import("numpy")
py_run_string("sys.path.append('/home/ohta/Atlas/python')") 
source_python("/home/ohta/Atlas/python/tools/test_processdata_ver2.py")
source_python("/home/ohta/Atlas/python/tools/test_syns.py")
source_python("/home/ohta/Atlas/python/tools/test_emgdata.py")
source_python("/home/ohta/Atlas/python/tools/test_coh_ver2.py")
source_python("/home/ohta/Atlas/python/tools/test_psd_ver2.py")
source_python("/home/ohta/Atlas/python/tools/test_ms.py")　#synsより後にインポートする
py_run_string("import warnings; warnings.simplefilter('ignore', DeprecationWarning)")
py_run_string("import warnings; warnings.simplefilter('ignore', UserWarning)")
py_run_string("import warnings; warnings.simplefilter('ignore', RuntimeWarning)")

# Source the UI and server scripts
source('/home/ohta/Atlas/study_graduation_research/ui/ui.R', local = TRUE)
source('/home/ohta/Atlas/study_graduation_research/sever/sever.R', local = TRUE)

# Create the Shiny app
shinyApp(ui = ui, server = server)
