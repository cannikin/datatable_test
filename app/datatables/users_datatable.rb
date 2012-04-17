class UsersDatatable < BaseDatatable

  datatable_for :user
  sort_by       ['last_name','first_name','email','dob','score']
  search_by     ['first_name','last_name','email']
  row           lambda { |user,view| 
                  [ user.last_name,
                    user.first_name,
                    user.email,
                    user.dob.strftime('%m/%d/%Y'),
                    user.score,
                    view.link_to('<i class="icon-edit"></i> Edit'.html_safe, view.edit_user_path(user), :class => 'btn btn-mini'),
                    view.link_to('<i class="icon-trash icon-white"></i>'.html_safe, view.user_path(user), :method => :delete, :class => 'btn btn-danger btn-mini')
                  ] }

end
