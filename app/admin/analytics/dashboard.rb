ActiveAdmin.register_page 'Dashboard' do
  content do
    panel 'Statistics' do
      columns do
        column do
          render partial: 'stat', locals: { stat_title: User.where(super_user: false).count, stat_context: 'Total users'}
        end
        column do
          render partial: 'stat', locals: { stat_title: User.where(super_user: false).where('created_at >= ?', (Time.now - 7.days)).count, stat_context: 'Users signed up in the last 7 days'}
        end
        column do
          render partial: 'stat', locals: { stat_title: User.where(super_user: false).where('passed_round_one_at != ? OR passed_round_two_at != ?', nil, nil).count, stat_context: 'Total users passed the course'}
        end
        column do
          render partial: 'stat', locals: { stat_title: User.where(super_user: false).where('failed_round_one_at != ? OR failed_round_two_at != ?', nil, nil).count, stat_context: 'Total users failed the course'}
        end
      end
    end
    panel 'Visualisations' do
      columns do
        column do
          render partial: 'viz1'
        end
        column do
          render partial: 'viz2'
        end
      end
    end
  end
end
