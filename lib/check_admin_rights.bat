net session >nul 2>&1
if %errorLevel% == 0 (
  set ADMIN=TRUE
  call log_with_time "Success: We have admin rights"
) else (
  set ADMIN=FALSE
  call log_with_time "Failure: We must be admin! Stopping!"
  exit
)
