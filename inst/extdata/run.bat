del RUNLOG
FOR /d %%A IN (*) DO (

    cd %%A
    
    ss3 -nohess
    
    copy starter.ss_new starter.ss
    copy data_echo.ss_new data.ss
    copy control.ss_new control.ss
    copy forecast.ss_new forecast.ss
    
    del report.*
    del *.ss_new
    del *.sso
    del *.log
    del ss*.r0*
    del ss*.p0*
    del ss*.b0*
    del ss*.bar
    del ss*.rep
    
    del runnumber.ss
    
    cd ..
    echo %%A >> "RUNLOG"
    
)


