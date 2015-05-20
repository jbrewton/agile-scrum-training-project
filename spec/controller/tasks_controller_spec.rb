describe TasksController, :type => :controller do

  describe "create" do
    it "should create a task object" do
      post :create, {task: {action_item: "pants"}}
      expect(Task.where(action_item: "pants")).to exist
    end
  end

  describe "update" do
    it "should update a task object" do
      @task = Task.create(action_item: "blem")
      put :update, :id => @task.id, task: {action_item: "pants"}
      expect(Task.where(action_item: "pants")).to exist
    end
  end

  describe "delete" do
    it "should delete a task object" do
      @task = Task.create(action_item: "pandas")
      delete :destroy, :id => @task.id
      expect(Task.where(action_item: "pandas")).to be_empty
    end
  end
end