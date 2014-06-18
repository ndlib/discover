# Add the export/email links dropdown at the record level rather than as part of the details tab.
jQuery ($) ->
  records = $('.EXLResult')
  if records.length > 0
    scopes = ''

    buildLinks = (record) ->
      recordID = record.find('.EXLResultRecordId').attr('id')
      console.log(recordID)

      linksHTML = """
        <div class="EXLTabHeaderButtons NDExportList">
          <ul>
            <li class="EXLTabHeaderButtonSendTo" style="list-style-type: none;"><a title="show send to options" id="in#{recordID}" name="in#{recordID}" href="#"><span></span>Export/E-mail <img alt="" src="../images/icon_arrow_sendTo.png"></a>
              <ol class="EXLTabHeaderButtonSendToList" style="display: none;">
                <li class="EXLButtonSendToMyShelf EXLButtonSendToMyShelfAdd">
                  <a href="#{addSessionId('basket.do')}?fn=create&amp;docs=#{recordID}&amp;exemode=async" title="Add to Folder" target="_blank">
                  <span class="EXLButtonSendToLabel">Add to Folder</span>
                  <span class="EXLButtonSendToIcon EXLButtonSendToIconMyShelf"></span>
                  </a>
                </li>
                <li class="EXLButtonSendToMyShelf EXLButtonSendToMyShelfRemove" style="display: none;">
                  <a href="#{addSessionId('basket.do')}?fn=remove&amp;docs=#{recordID}&amp;exemode=async" title="Remove from Folder" target="_blank">
                  <span class="EXLButtonSendToLabel">Remove from Folder</span>
                  <span class="EXLButtonSendToIcon EXLButtonSendToIconMyShelf"></span>
                  </a>
                </li>
                <li class="EXLButtonSendToMail">
                  <a href="#{addSessionId('email.do')}?fn=email&amp;docs=#{recordID}&amp;vid=NDU&amp;fromCommand=true&amp;doc=#{recordID}&amp;scope=#{escape(scopes)}&amp;indx=1&amp;" title="Send record by E-mail(opens in a new window)" target="_blank">
                  <span class="EXLButtonSendToLabel">E-mail</span>
                  <span class="EXLButtonSendToIcon EXLButtonSendToIconMail"></span>
                  </a>
                </li>
              </ol>
            </li>
          </ul>
        </div>
      """
      container = $(linksHTML)
      container.find('.EXLButtonSendToMyShelfAdd a').click (event) ->
        event.preventDefault()
        eshelfCreate(this,recordID,'false',scopes,'1')
      container.find('.EXLButtonSendToMyShelfRemove a').click (event) ->
        event.preventDefault()
        eshelfRemove(this,recordID,'false',scopes,'1')
      container.find('.EXLButtonSendToMail a').click (event) ->
        event.preventDefault()
        sendPrintPopOut(this)

      record.find('.EXLSummaryFields').after(container)

    ready = ->
      scopes = $('#scopesListContainer').find('input:checked').val()
      records.each ->
        record = $(this)
        buildLinks(record)

    $(document).ready(ready)
