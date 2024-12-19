withProgress(message = "Processing Data", value = 0, {
  #若年
  #データの処理
  process_data_y <- group_emg_data("Young", "noRAS1", num_subjects=as.integer(4))
  emg_data_y <<- process_data_y[[1]]
  epochs_data_y <<- process_data_y[[2]]
  norm_data_y <<- process_data_y[[3]]
  psd_y <<- process_data_y[[4]]
  muscles_y <<- process_data_y[[5]]
  incProgress(1/8, detail = "Processed young data")
  
  #シナジー解析
  #result_y = calc_cNMF(epochs_data_y, confidence_level=0.95)
  result_y = calc_cNMF(norm_data_y, muscles = muscles_y[1:7], confidence_level=0.95)
  combined_data_y <<- result_y[[1]]
  m_cNMF_y <<- result_y[[2]]
  mean_W_y <<- result_y[[3]]
  confidence_interval_y <<- result_y[[4]]
  incProgress(1/8, detail = "Synergy analysis for young data")
  
  #psd解析（ヒートマップ）
  psd_data_y <<- group_psd_data(psd_y, muscles_y, num_subjects=as.integer(4)) 
  means_y <<- psd_data_y[[1]]
  err_y <<- psd_data_y[[2]]
  incProgress(1/8, detail = "PSD analysis for young data")
  
  #emgデータ（ヒートマップ）
  mean_data_y <<- np$mean(norm_data_y, axis=as.integer(0))
  incProgress(1/8, detail = "EMG data heatmap for young data")
  
  #コヒーレンス解析
  coherence_data_y <<- collect_coherence_test(emg_data_y, muscles_y, Fs=200)
  incProgress(1/8, detail = "Coherence analysis for young data")
  
  #高齢
  #データの処理
  process_data_e <- group_emg_data("Elderly", "noRAS1", num_subjects=as.integer(4))
  emg_data_e <<- process_data_e[[1]]
  epochs_data_e <<- process_data_e[[2]]
  norm_data_e <<- process_data_e[[3]]
  psd_e <<- process_data_e[[4]]
  muscles_e <<- process_data_e[[5]]
  incProgress(1/8, detail = "Processed elderly data")
  
  #シナジー解析
  #result_e = calc_cNMF(epochs_data_e, confidence_level=0.95)
  result_e = calc_cNMF(norm_data_e, muscles = muscles_e[1:7], confidence_level=0.95)
  combined_data_e <<- result_e[[1]]
  m_cNMF_e <<- result_e[[2]]
  mean_W_e <<- result_e[[3]]
  confidence_interval_e <<- result_e[[4]]
  incProgress(1/8, detail = "Synergy analysis for elderly data")
  
  #psd解析（ヒートマップ）
  psd_data_e <<- group_psd_data(psd_e, muscles_e, num_subjects=as.integer(4))
  means_e <<- psd_data_e[[1]]
  err_e <<- psd_data_e[[2]]
  incProgress(1/8, detail = "PSD analysis for elderly data")
  
  #emgデータ（ヒートマップ）
  mean_data_e <<- np$mean(norm_data_e, axis=as.integer(0))
  incProgress(1/8, detail = "EMG data heatmap for elderly data")
  #コヒーレンス解析
  coherence_data_e <<- collect_coherence_test(emg_data_e, muscles_e, Fs=200)
  incProgress(1/8, detail = "Coherence analysis for elderly data")
})

output$plot_y <- renderPlot({
  req(input$start)
  if (input$data == "example") {
    if (input$plottype == "filt_heat") {
      heatmap_mean_emg(mean_data_y, muscles_y)
    }
    
    else if (input$plottype == "psd_heat") {
      plot_psd_heatmaps(means_y, muscles_y, fmin=0, fmax=500)
      
    }
    
    else if (input$plottype == "coh_heat") {
      test_coh_coh_heatmap(coherence_data_y)
    } 
    else {
      plot_syns(m_cNMF_y, mean_W_y, confidence_interval_y)
    }
  }
  
  else {
    print("no data")
  }
})

output$plot_e <- renderPlot({
  req(input$start)
  if (input$data == "example") {
    if (input$plottype == "filt_heat") {
      heatmap_mean_emg(mean_data_e, muscles_e)
    }
    
    else if (input$plottype == "psd_heat") {
      plot_psd_heatmaps(means_e, muscles_e, fmin=0, fmax=500)
      
    }
    
    else if (input$plottype == "coh_heat") {
      test_coh_coh_heatmap(coherence_data_e)
    } 
    else {
      plot_syns(m_cNMF_e, mean_W_e, confidence_interval_e)
    }
  }
})