library(whisker)

# exposed functions and argc
data <- read.table("inst/expose-generator/functions.csv", header = TRUE)

call_method.template <- readLines("inst/expose-generator/call_method.template")
call_method <- c()

register_c_callable.template <- readLines("inst/expose-generator/register_c_callable.template")
register_c_callable <- c()

for(i in seq_len(nrow(data))) {
    call_method <- append(call_method, whisker.render(call_method.template, data[i,]))
    register_c_callable <- append(register_c_callable, whisker.render(register_c_callable.template, data[i,]))
}

init.c.template <- readLines("inst/expose-generator/init.c.template")
retval <- whisker.render(init.c.template,
               list(
                   call_method = paste(sprintf("    %s", call_method), collapse = "\n"),
                   register_c_callable = paste(sprintf("    %s", register_c_callable), collapse = "\n")
               ))
write(retval, "src/init.c")
