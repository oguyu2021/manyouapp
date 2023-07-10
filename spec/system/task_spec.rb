require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task') }
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # 適切なURLにアクセスする
        visit new_task_path
        # Titleに入力
        fill_in 'task[title]', with: 'Test Task'
        # Contentにも入力
        fill_in 'task[content]', with: 'Test Task Content'
        # create Taskボタンをクリック
        click_button '登録する'
        # 入力した文字が画面に出ていたらテスト成功
        expect(page).to have_content 'Test Task'
        expect(page).to have_content 'Test Task Content'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        FactoryBot.create(:task, title: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_test = all('tb').first
        expect(task_test)
      end
    end
  end
  describe '詳細表示機能' do
      context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          # テストで作成するためのタスクを作成
          task = FactoryBot.create(:task, title: 'task', content: 'task content')
          # タスク一覧ページに遷移
          visit tasks_path
          # "詳細を確認する"を押す
          click_link '詳細を確認する', href: task_path(task)
          # 詳細画面に移動したことを確認
          expect(current_path).to eq task_path(task)
          # 該当したタスクが表示されたことを確認
          expect(page).to have_content 'task'
          expect(page).to have_content 'task content'
        end
      end
   end
end
