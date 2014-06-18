# Add the export/email links dropdown at the record level rather than as part of the details tab.
jQuery ($) ->
  records = $('.EXLResult')
  if records.length > 0
    scopes = ''
    vid = ''
    tab = ''

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
                  <a href="#{addSessionId('email.do')}?fn=email&amp;docs=#{recordID}&amp;vid=#{vid}&amp;fromCommand=true&amp;doc=#{recordID}&amp;scope=#{escape(scopes)}&amp;indx=1&amp;" title="Send record by E-mail(opens in a new window)" target="_blank">
                  <span class="EXLButtonSendToLabel">E-mail</span>
                  <span class="EXLButtonSendToIcon EXLButtonSendToIconMail"></span>
                  </a>
                </li>
                <li class="EXLButtonSendToPrint">
                  <a href="#{addSessionId('display.do')}?fn=print&amp;tab=#{tab}&amp;indx=1&amp;display=print&amp;docs=#{recordID}&amp;indx=1&amp;" onclick="boomCallToRum('sendTo_print_0',false);javascript:sendPrintPopOut(this);return false;" title="Print record (opens in a new window)" target="blank">
                  <span class="EXLButtonSendToLabel">Print</span>
                  <span class="EXLButtonSendToIcon EXLButtonSendToIconPrint"></span>
                  </a>
                </li>
                <li class="EXLButtonSendToPermalink">
                  <a href="#{addSessionId('permalink.do')}?docId=#{recordID}&amp;vid=#{vid}&amp;fn=permalink" onclick="boomCallToRum('sendTo_Permalink_0',false);javascript:openPermaLinkLbox('permalink','docId=#{recordID}&amp;vid=#{vid}&amp;fn=permalink','0','#{recordID}');return false;" title="Permanent URL for this record" target="blank">
                  <span class="EXLButtonSendToLabel">Permalink</span>
                  <span class="EXLButtonSendToIcon EXLButtonSendToIconPermalink"></span></a>
                </li>
                <li class="EXLButtonSendToCitation">
                  <a href="#" onclick="boomCallToRum('sendTo_citation_0',false);openCitationLbox('0','#{recordID}');return false;" title="Bibliographic citation for this title" target="blank">
                  <span class="EXLButtonSendToLabel">Citation</span>
                  <span class="EXLButtonSendToIcon EXLButtonSendToIconCitation"></span>
                  </a>
                </li>
                <li class="EXLButtonSendToDelicious">
                  <a href="#{addSessionId('PushToAction.do')}?recId=#{recordID}&amp;pushToType=EndNote&amp;fromEshelf=false" title="Add toEndNote" onclick="boomCallToRum('sendTo_pushto_0_0',false);pushto('EndNote','1','false','#{recordID}');return false;" target="blank">
                    <span class="EXLButtonSendToLabel">
                      EndNote</span>
                    <span class="EXLButtonSendToIcon EXLButtonSendToIconEndNote"></span>
                  </a>
                </li>
                <li class="EXLButtonSendToDelicious">
                  <a href="#{addSessionId('PushToAction.do')}?recId=#{recordID}&amp;pushToType=RefWorks&amp;fromEshelf=false" title="Add toRefWorks" onclick="boomCallToRum('sendTo_pushto_0_1',false);pushto('RefWorks','1','false','#{recordID}');return false;" target="blank">
                    <span class="EXLButtonSendToLabel">
                      RefWorks</span>
                    <span class="EXLButtonSendToIcon EXLButtonSendToIconRefWorks"></span>
                  </a>
                </li>
                <li class="EXLButtonSendToDelicious">
                  <a href="#{addSessionId('PushToAction.do')}?recId=#{recordID}&amp;pushToType=Delicious&amp;fromEshelf=false" title="Add toDelicious" onclick="boomCallToRum('sendTo_pushto_0_2',false);pushto('Delicious','1','false','#{recordID}');return false;" target="blank">
                    <span class="EXLButtonSendToLabel">
                      del.icio.us</span>
                    <span class="EXLButtonSendToIcon EXLButtonSendToIconDelicious"></span>
                  </a>
                </li>
                <li class="EXLButtonSendToDelicious">
                  <a href="#{addSessionId('PushToAction.do')}?recId=#{recordID}&amp;pushToType=RISPushTo&amp;fromEshelf=false" title="Add toRISPushTo" onclick="boomCallToRum('sendTo_pushto_0_3',false);pushto('RISPushTo','1','false','#{recordID}');return false;" target="blank">
                    <span class="EXLButtonSendToLabel">
                      Export RIS</span>
                    <span class="EXLButtonSendToIcon EXLButtonSendToIconRISPushTo"></span>
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
      vid = $('#vid').val()
      tab = $('#tab').val()
      records.each ->
        record = $(this)
        buildLinks(record)

    $(document).ready(ready)
