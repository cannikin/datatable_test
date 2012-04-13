# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#users').dataTable
    iDisplayLength: 25
    bDeferRender: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#users').data('source')
    bScrollInfinite: true
    bScrollCollapse: true
    sScrollY: '600px'
    iScrollLoadGap: 100
    # bStateSave: true
    aoColumnDefs: [{bSortable: false, aTargets: [5,6]}]

  # make the search box look like a search box
  $('.dataTables_filter input').addClass('search-query')
