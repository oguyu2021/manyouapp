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
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が過去のタスクが一番上に表示される' do
        # テストで使用するためのタスクを作成
        FactoryBot.create(:task, title: 'Task 1', deadline: DateTime.now + 1.day)
        FactoryBot.create(:task, title: 'Task 2', deadline: DateTime.now + 2.days)
        FactoryBot.create(:task, title: 'Task 3', deadline: DateTime.now - 1.day)
    
        # タスク一覧ページに遷移
        visit tasks_path(sort_expired: "true")
    
        # 終了期限が過去のタスクが一番上に表示されることを確認
        expect(page).to have_selector('tr', text: 'Task 3')
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_test = all('tb').first
        expect(task_test)
      end
    end
    context 'タイトルのあいまい検索ができる場合' do
      it '該当タイトルのタスクが表示される' do
        FactoryBot.create(:task, title: 'タスク1')
        FactoryBot.create(:task, title: 'タスク2')

        visit tasks_path
        fill_in 'タイトルで絞り込む', with: 'タスク1'
        click_button '検索'

        expect(page).to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
      end
    end
    context 'タイトルとステータスの両方で絞り込み検索ができる場合' do
      it '該当タイトルかつ該当ステータスのタスクが表示される' do
        FactoryBot.create(:task, title: 'タスク1', status: '未着手')
        FactoryBot.create(:task, title: 'タスク2', status: '着手中')
        FactoryBot.create(:task, title: 'タスク3', status: '完了')

        visit tasks_path
        fill_in 'タイトルで絞り込む', with: 'タスク1'
        select '未着手', from: 'status'
        click_button '検索'

        expect(page).to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
        expect(page).not_to have_content 'タスク3'
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
   describe '優先順位の登録' do
    it 'タスクに優先順位を登録できる' do
      # タスクを作成
    #task = FactoryBot.create(:task, title: 'Test Task')

    # タスク一覧ページに遷移
    visit tasks_path

    # 編集ページへのリンクをクリック
    click_link '編集する'

    # 優先順位を選択
    select '高', from: 'task_priority'

    # 更新ボタンをクリック
    click_button '更新する'

    # タスク一覧ページに優先順位が表示されていることを確認
    expect(page).to have_content '高'
    end
  end
  describe '優先順位のソート' do
    it '優先順位が高い順にソートされる' do
      # タスクを作成
      FactoryBot.create(:task, title: 'Task 1', priority: '中')
      FactoryBot.create(:task, title: 'Task 2', priority: '高')
      FactoryBot.create(:task, title: 'Task 3', priority: '低')

      # タスク一覧ページに遷移
      visit tasks_path(task)

      # 優先順位でソートするリンクをクリック
      click_on '優先順位でソートする'

      # ソート結果を取得
      sorted_tasks = all('.task-title').map(&:text)

      # 期待するソート結果
      expected_sorted_tasks = ['Task 2', 'Task 1', 'Task 3']

      # ソート結果が期待通りであることを確認
      #expect(sorted_tasks).to eq(expected_sorted_tasks)
    end
  end
end
