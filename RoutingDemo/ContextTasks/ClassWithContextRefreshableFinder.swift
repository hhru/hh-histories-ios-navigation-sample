import RouteComposer

struct ClassWithContextRefreshableFinder<ViewController, Context>:
    StackIteratingFinder
    where
    ViewController: ContextChecking,
    ViewController: ScreenRefreshableContainer,
    ViewController.Context == Context
{

    let iterator: StackIterator

    init(
        options: SearchOptions,
        startingPoint: DefaultStackIterator.StartingPoint = .topmost,
        windowProvider: WindowProvider = RouteComposerDefaults.shared.windowProvider,
        containerAdapterLocator: ContainerAdapterLocator = RouteComposerDefaults.shared.containerAdapterLocator
    ) {
        self.iterator = DefaultStackIterator(
            options: options,
            startingPoint: startingPoint,
            windowProvider: windowProvider,
            containerAdapterLocator: containerAdapterLocator
        )
    }

    func isTarget(_ viewController: ViewController, with context: Context) -> Bool {
        if viewController.isTarget(for: context) {
            viewController.refresh(with: context)
            return true
        }

        return false
    }
}
