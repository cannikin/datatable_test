class UsersDatatable < Datatable::Base

  table_for   :user
  sort_by     ['last_name','first_name','email','dob','score']
  search_by   ['first_name','last_name','email']
  row         lambda { |u,view| 
                [ u.last_name,
                  u.first_name,
                  u.email,
                  u.dob.strftime('%m/%d/%Y'),
                  u.score,
                  view.link_to('Edit', view.edit_user_path(u), :class => 'btn btn-mini'),
                  view.link_to('<i class="icon-trash icon-white"></i>'.html_safe, view.user_path(u), :method => :delete, :class => 'btn btn-danger btn-mini')
                ] }

end
