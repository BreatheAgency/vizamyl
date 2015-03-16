ActiveAdmin.register_page 'Dashboard' do
  content do
    panel 'Statistics' do
      columns do
        column do
          render partial: 'users_total'
        end
        column do
          render partial: 'users_total'
        end
        column do
          render partial: 'users_total'
        end
        column do
          render partial: 'users_total'
        end
      end
    end
    panel 'Visualisations' do
      render partial: 'viz'
    end
  end
end
