# Add the export/email links dropdown at the record level rather than as part of the details tab.
jQuery ($) ->
  records = $('.EXLSummary')
  if records.length > 0
    buildLinks = (record) ->
      container = $('<div class="EXLTabHeaderButtons NDExportList"></div>')
      ul = $('<ul></ul>')
      container.append(ul)
      li = $('<li class="EXLTabHeaderButtonSendTo" style="list-style-type: none;"><a title="show send to options" id="inndu_aleph002273293" name="inndu_aleph002273293" href="#"><span></span>Export/E-mail <img alt="" src="../images/icon_arrow_sendTo.png"></a>')
      ul.append(li)
      record.find('.EXLSummaryFields').after(container)

    records.each ->
      record = $(this)
      buildLinks(record)
