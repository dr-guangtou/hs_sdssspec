pro hvdisp_coadd_pipe, input_list, new_prep=new_prep

    input_list = strcompress( input_list, /remove_all ) 
    if NOT file_test( input_list ) then begin 
        message, ' Can not find the input list : ' + input_list + ' !!!'
    endif else begin 
        readcol, input_list, html_list, format='A', delimiter=' ', $
            comment='#', /silent, count=n_html  
    endelse

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    for ii = 0, ( n_html - 1 ), 1 do begin  

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        html_file = strcompress( html_list[ ii ], /remove_all ) 
        print, '  '
        print, '###############################################################'
        print, ' Coadd : ' + html_file
        print, '###############################################################'
        print, '  '
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;; 
        if ( strpos( html_file, 'z0_' ) NE -1 ) then begin 
            min_wave_hard = 3740.0 
            max_wave_hard = 8420.0 
            red_cut   = 160.0 
            blue_cut  = 160.0
            f_cushion = 10.0
        endif 
        ;;
        if ( strpos( html_file, 'z1_' ) NE -1 ) then begin 
            min_wave_hard = 3740.0 
            max_wave_hard = 8580.0 
            red_cut   = 160.0 
            blue_cut  = 160.0
            f_cushion = 10.0
        endif 
        ;;
        if ( strpos( html_file, 'z2_' ) NE -1 ) then begin 
            min_wave_hard = 3740.0 
            max_wave_hard = 7980.0 
            red_cut  = 160.0 
            blue_cut = 160.0
            f_cushion = 8.0
        endif 
        ;;
        if ( strpos( html_file, 'z3_' ) NE -1 ) then begin 
            min_wave_hard = 3740.0 
            max_wave_hard = 7760.0 
            red_cut   = 160.0 
            blue_cut  = 160.0
            f_cushion = 8.0
        endif 

        print, '###############################################################'
        print, ' MIN_WAVE_HARD : ', min_wave_hard
        print, ' MAX_WAVE_HARD : ', max_wave_hard
        print, '   RED_CUT     : ', red_cut 
        print, '   BLU_CUT     : ', blue_cut 
        print, '  F_CUSHION    : ', f_cushion 
        print, '###############################################################'

        ;; Test A 
        if keyword_set( new_prep ) then begin 
            hs_coadd_sdss_pipe, html_file, /create, /post, /avg_boot, $
                n_boot=2000, sig_cut=3.5, f_cushion=f_cushion, $
                min_wave_hard=min_wave_hard, max_wave_hard=max_wave_hard, $
                red_cut=red_cut, blue_cut=blue_cut, $
                /new_prep
        endif else begin 
            hs_coadd_sdss_pipe, html_file, /create, /post, /avg_boot, $
                n_boot=2000, sig_cut=3.5, f_cushion=f_cushion, $
                red_cut=red_cut, blue_cut=blue_cut, $
                min_wave_hard=min_wave_hard, max_wave_hard=max_wave_hard
        endelse

        ;;
    endfor

end
