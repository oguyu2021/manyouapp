require 'rails_helper'

RSpec.describe 'ラベル機能', type: :system do
  context 'タスクの新規作成の時に' do
    it 'タスクにラベルを登録できる' do
      FactoryBot.create(:label)
      User.create!(
        name: 'testuser2',
        email: 'test2@code.com',
        password: 'testcode'
      )
      visit new_session_path
      fill_in 'session[email]', with: 'test2@code.com'
      fill_in 'session[password]', with: 'testcode'
      click_on 'Log in'
      click_on 'タスク一覧'
      click_on '新しくタスクを投稿する'
      sleep(1)
      fill_in 'task_title', with: 'hoge'
      fill_in 'task_content', with: 'hoge@hoge.com'
      fill_in 'task_deadline', with: '002023-07-07'
      select '未着手', from: 'task[status]'
      select '高', from: 'task[priority]'
      # select 'Label1', from: 'Label'
      check 'Label1'
      click_on '登録する'
      expect(page).to have_content 'Label1'
    end
  end
      context 'ラベル検索をした時に' do
        it 'ラベル検索ができる' do
        FactoryBot.create(:label)
        User.create!(
        name: 'testuser2',
        email: 'test2@code.com',
        password: 'testcode'
        )
        visit new_session_path
        fill_in 'session[email]', with: 'test2@code.com'    
        fill_in 'session[password]', with: 'testcode'    
        click_on 'Log in'
        click_on 'タスク一覧'
        click_on '新しくタスクを投稿する'
        sleep(1)
        fill_in 'task_title', with: 'hoge'
        fill_in 'task_content', with: 'hoge@hoge.com'
        fill_in 'task_deadline', with: '002023-07-07'
        select '未着手', from: "task[status]"
        select '高', from: "task[priority]"
        check 'Label1'
        click_on '登録する'
        visit tasks_path
        select 'Label1', from: "task[label_id]"
        sleep(3)
        click_on '検索'
        expect(page).to have_content 'Label1'  
        end        
     end  
end
