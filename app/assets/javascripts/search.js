function initSelectize() {
  $('#search_skill_ids').selectize({});
}

$(document).ready(initSelectize);
$(document).on('page:load', initSelectize);
