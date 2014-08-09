// holds the currently displayed view
var currentView;

// holds the current view history
var viewHistory = new Array();

function showView(nextView)
{
    if(nextView.visible)
    {
        var isPreviousView = false;
        if (viewHistory[viewHistory.length - 1] == nextView) {
            isPreviousView = true;
            viewHistory.pop();
        }

        if(nextView != currentView)
        {
            /*currentView.anchors.fill = nextView.anchors.fill = null;
        currentView.width = nextView.width = currentView.width;
        currentView.height = nextView.height = currentView.height;*/
            nextView.x = viewManager.width * (isPreviousView ? -1 : 1);

            if(currentViewAnimation.running)
                currentViewAnimation.complete();

            if(nextViewAnimation.running)
                nextViewAnimation.complete();

            currentViewAnimation.target = currentView;
            currentViewAnimation.to = viewManager.width * (isPreviousView ? 1 : -1);
            currentViewAnimation.running = true;

            nextViewAnimation.target = nextView;
            nextViewAnimation.to = - 0;
            nextViewAnimation.running = true;

            if(currentView && !isPreviousView)
            {
                viewHistory.push(currentView);
            }
            currentView = nextView;
        }
    }
}

function connectViewEvents(view)
{
    view.visibleChanged.connect(function() {
        SVM.showView(view);
    });
}

function previousView()
{
    if (viewHistory.length < 1) return;
    var previousView = viewHistory[viewHistory.length - 1];
    previousView.visible = true;
    showView(previousView);
}
