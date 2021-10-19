//
//  MainScreenView.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 7/10/21.
//

import SwiftUI

struct MainScreenView<ViewModel>: View where ViewModel: MainScreenViewModelProtocol {
    // MARK: - Properties
    // Donde se definen las constantes que se emplearán, como son:
    // el ViewModel y el connector que controlan la vista ...
    private let connector: MainScreenConnectorProtocol
    @ObservedObject private var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme

    // Así como los tamaños que serán utilizados para los elementos.
    // De esta manera, los tamaños quedan localizados y es más rápido cambiarlos.
    private let generalPadding: CGFloat = 16
    private let magnifyingglassAspectRatio: CGFloat = 20/20
    private let magnifyingglassHeight: CGFloat = 20
    private let smallIconsAspectRatio: CGFloat = 15/15
    private let smallIconsHeight: CGFloat = 15
    private let smallPadding: CGFloat = 8
    private let bottomListPadding: CGFloat = 28

    // MARK: - Initializer
    /*
     En el init se da valor a aquellos elementos que son requeridos, pero también
     se puede dar valor a variables que dependan de otras, o cambios en el
     comportamiento de elementos UI (rebote en listas, ...)
     */
    init(viewModel: ViewModel, connector: MainScreenConnectorProtocol) {
        self.viewModel = viewModel
        self.connector = connector
        UITableView.appearance().bounces = false
    }
    
    // Es la vista, donde se introduce en contenedores los elementos a mostrar.
    // En este caso, no es necesaria la navegación, por lo que no se incluye.
    var body: some View {
        // Un VStack es el contenedor vertical de elementos; los mostrará en el orden
        // que se especificaron en código, en la pantalla. Centrados por defecto.
        VStack {
            // MARK: - Header + Search button
            // Un HStack es el contenedor horizontal de elementos; los mostrará en el orden que
            // se especificaron en código, en la pantalla. Centrados verticalmente por defecto.
            HStack {
                // Tip: En este caso se emplean 2 HStack para aplicar 2 fondos (statusBar)
                HStack {
                    // Un Text es la etiqueta de texto por defecto de Swift, se pueden realizar tus
                    // propias fuentes, o usar las de sistema modificadas en aspecto, tamaño y color
                    Text("ComposePlayground")
                        .foregroundColor(Color.white)
                        .bold()
                    
                    Spacer()
                    
                    // A un botón podemos darle una acción a realizar cuando es pulsado.
                    // Y su aspecto visual, pudiendo ser una imagen, texto, fondo... o combinaciones.
                    Button(action: {},
                           label: {
                        Image(systemName: "magnifyingglass")
                        // SwiftUI permite que las imagenes se ajusten al tamaño disponible,
                        // siguiendo una determinada relación de aspecto.
                            .aspectRatio(smallIconsAspectRatio, contentMode: .fit)
                        // ... y tampoco ocupar más de lo permitido, mediante un marco que lo delimita
                            .frame(width: smallIconsHeight, height: smallIconsHeight)
                            .foregroundColor(Color.white)
                    })
                    // Aplicar un estilo de botón personalizado o nativo permite acabar con problemas,
                    // como sería el caso de un aspecto azulado en ciertos iOS
                        .buttonStyle(PlainButtonStyle())
                }
                // Los paddings son espacios invisibles que permiten separar elementos
                .padding(generalPadding)
                // El operador ternario es útil para reducir la complejidad :)
                // Este es el color de fondo del HStack
                .background(colorScheme == ColorScheme.dark ? Color.black : Color.purple_500)
            }
            // Y este el fondo de la status bar (barra superior de iOS) que ...
            .background(Color.purple_700
                        // puede darse porque estamos evitando espacio superior.
                            .edgesIgnoringSafeArea(.top))
            
            // MARK: - Clean + Fill buttons
            HStack {
                // También podemos crear un botón personalizado si vamos a usarlo más veces.
                // De esta manera conseguimos un código más limpio, estructurado y mantenible.
                MainButton(label: "Clean", action: viewModel.emptyPosts)
                    .padding(.leading, generalPadding)
                
                /*
                 Un spacer actua como un padding, es decir introduce un espacio entre elementos,
                 pero el espacio será todo el disponible, es calculado automáticamente.
                 Aunque puede tener un espacio mínimo que introducir, como es el caso.
                 */
                Spacer(minLength: generalPadding)
                
                MainButton(label: "Fill".localized(), action: viewModel.fillPosts)
                    .padding(.trailing, generalPadding)
            }
            // Los padding se pueden aplicar a cualquiera de los 4 lados...
            .padding([.top, .bottom], generalPadding/2)
            
            // MARK: - Post's list
            // La vista puede tener lógica, pero muy pequeña
            if viewModel.posts.isEmpty {
                Text("Empty list")
                
                Spacer()
            } else {
                /*
                 Una lista es un contenedor vertical (por defecto), scrolleable que muestra
                 los elementos de forma ordenada y separada. Permitiendo acciones con estos si:
                 1) El elemento es un botón (con su label correspondiente)
                 ... o
                 2) Se integra un .onTapGesture{ accion_requerida } en el elemento.
                 
                 Salvo que toda la fila deba ser pulsable, es mejor dejar los gestos para
                 la vista del elemento, pues así podremos tener más de una acción.
                 */
                List {
                    ForEach(viewModel.posts) { post in
                        MainScreenItemView(item: post)
                        // Para evitar los espacios nativos de las listas se debe especificar
                        // como deben tratarse los margenes de cada elemento...
                            .listRowInsets(EdgeInsets())
                    }
                    .padding(.bottom, bottomListPadding)
                }
                // y tampoco debe tener formato la lista, para que se ajuste al diseño propio.
                .listStyle(PlainListStyle())
            }
        }.background(colorScheme == ColorScheme.dark ? Color.grey_title : Color.white)
        /*
         En el onAppear se especifican las acciones que se realizan al cargar la vista,
         en este caso, cargar la lista de posts, para lo cual se llama al ViewModel.
         
         Existen otros eventos, como onDisappear, que puede ser útil p.ej. para guardar cambios.
         */
        .onAppear {
            viewModel.fillPosts()
        }
        // MARK: - Add post overlay
        // Para mostrar vistas por cima o un botón flotante, lo más simple es añadir un
        // overlay a la vista. En este caso se trata de otra vista, con un botón.
        .overlay(
            AddPostButtonView(label: "Add a new post",
                              action: {})
        )
    }
}

// MARK: - Preview
#if DEBUG

/*
 Una de las ventajas de SwiftUI es que permite visualizar a la derecha en el Canvas el aspecto
 de la vista según se añaden elementos, no teniendo que compilar cada vez, ahorrando tiempo.
 
 Para ello se debe crear el struct que contendrá y mostrará la vista que acabamos de crear...
 Y previamente se añaden todos los parámetros necesarios, así como las funciones declaradas en el
 viewModel, aunque estén vacías.
 */

class PreviewMainScreenViewModel: MainScreenViewModelProtocol {
    var posts: [MainScreenItemViewModel] = PreviewMainScreenItemViewModel.initialPosts

    init() {}
    
    func emptyPosts() {}
    func fillPosts() {}
}

class PreviewMainScreenConnector: MainScreenConnectorProtocol {}

struct MainScreenView_Previews: PreviewProvider {

    static let viewModel = PreviewMainScreenViewModel()

    static let connector = PreviewMainScreenConnector()

    static var previews: some View {

        MainScreenView(viewModel: viewModel, connector: connector)
            .colorScheme(.light)
    }
}

#endif
