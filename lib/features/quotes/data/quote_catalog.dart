import 'dart:math';

import '../models/quote.dart';

class QuoteCatalog {
  late final List<Quote> quotes;
  static const _months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  QuoteCatalog() {
    quotes = List.unmodifiable(const [
      Quote(
          "Enero 1",
          "Estoy convencido de que por lo menos la mitad de lo que separa a los emprendedores exitosos de los que no lo son es mera perseverancia.",
          "Steve Jobs"),
      Quote(
          "Enero 2",
          "La riqueza, después de todo, es algo relativo, ya que el que tiene poco y quiere menos es más rico que el que tiene más y quiere aún más.",
          "Charles Caleb Colton"),
      Quote("Enero 3", "No puedes salvar a las personas; solo puedes amarlas.",
          "Anaïs Nin"),
      Quote(
          "Enero 4",
          "El modo de dar una vez en el clavo es dar cien veces en la herradura.",
          "Coronel Sanders"),
      Quote(
          "Enero 5",
          "El que pierde dinero pierde mucho; el que pierde un amigo pierde aún más; el que pierde la fe lo pierde todo.",
          "Eleanor Roosevelt"),
      Quote(
          "Enero 6",
          "Mantén una visión global mientras atiendes los detalles cotidianos.",
          "Donald Trump"),
      Quote("Enero 7", "Haz lo que puedas, con lo que tengas, donde estés.",
          "Theodore Roosevelt"),
      Quote(
          "Enero 8",
          "No importa cuántas veces falles; solo tienes que acertar una vez. Entonces todos te llamarán un éxito de la noche a la mañana y te dirán lo afortunado que eres.",
          "Mark Cuban"),
      Quote(
          "Enero 9",
          "Nunca vayas por el camino trazado, porque conduce hacia donde otros ya han estado.",
          "Alexander Graham Bell"),
      Quote(
          "Enero 10",
          "Si no te gusta tomar riesgos, debes salir corriendo del negocio.",
          "Ray Kroc"),
      Quote("Enero 11", "El éxito es 1 % inspiración y 99 % transpiración.",
          "Thomas Edison"),
      Quote(
          "Enero 12",
          "Tu trabajo va a ocupar gran parte de tu vida. La única manera de estar realmente satisfecho es hacer lo que creas que es un gran trabajo, y la única manera de hacerlo es amar lo que haces. Si no lo has encontrado aún, sigue buscando. Como con todo lo que tiene que ver con el corazón, sabrás cuando lo hayas encontrado.",
          "Steve Jobs"),
      Quote(
          "Enero 13",
          "Mantén siempre los ojos abiertos, observando, porque cualquier cosa que veas puede inspirarte.",
          "Grace Coddington"),
      Quote("Enero 14", "Las oportunidades no ocurren, se crean.",
          "Chris Grosser"),
      Quote(
          "Enero 15",
          "Compra solo algo con lo que seguirías siendo feliz si el mercado cerrara durante diez años.",
          "Warren Buffett"),
      Quote(
          "Enero 16",
          "No puedes escapar de la responsabilidad de mañana evadiéndola hoy.",
          "Abraham Lincoln"),
      Quote("Enero 17", "El dinero no te hace feliz, pero relaja los nervios.",
          "Sean O’Casey"),
      Quote(
          "Enero 18",
          "Realmente soy un soñador práctico; mis sueños no son bagatelas en el aire. Lo que yo quiero es convertir mis sueños en realidad.",
          "Mahatma Gandhi"),
      Quote(
          "Enero 19",
          "Hay muchas malas razones para empezar una empresa. Pero solo hay una buena razón y creo que sabes cuál es: para cambiar el mundo.",
          "Phil Libin"),
      Quote("Enero 20", "Da siempre más de lo que se espera de ti.",
          "Larry Page"),
      Quote(
          "Enero 21",
          "Muévete rápido y rompe objetos. Si no estás rompiendo cosas, no te estás moviendo lo suficientemente rápido.",
          "Mark Zuckerberg"),
      Quote(
          "Enero 22",
          "El futuro pertenece a quienes creen en la belleza de sus sueños.",
          "Eleanor Roosevelt"),
      Quote(
          "Enero 23",
          "Da el primer paso con fe. No es necesario que veas toda la escalera; solo da el primer paso.",
          "Martin Luther King"),
      Quote("Enero 24", "El dinero cuesta mucho a menudo.",
          "Ralph Waldo Emerson"),
      Quote(
          "Enero 25",
          "Un optimista ve una oportunidad en toda calamidad, un pesimista ve una calamidad en toda oportunidad.",
          "Winston Churchill"),
      Quote(
          "Enero 26",
          "Nuestra gloria más grande no consiste en no haberse caído nunca, sino en haberse levantado después de cada caída.",
          "Confucio"),
      Quote(
          "Enero 27",
          "La cosa más importante que debes hacer si estás dentro de un hoyo es dejar de cavar.",
          "Warren Buffett"),
      Quote(
          "Enero 28",
          "Odio cómo piensa la gente con el “vaso medio vacío” cuando en realidad su vaso está casi lleno. Estoy agradecido cuando tengo una gota más en el vaso porque sé exactamente qué hacer con ella.",
          "Gary Vaynerchuk"),
      Quote(
          "Enero 29",
          "Es duro fracasar, pero es todavía peor no haber intentado nunca triunfar.",
          "Theodore Roosevelt"),
      Quote(
          "Enero 30",
          "La gente puede ser muy inteligente o tener habilidades que son aplicables, pero si no creen en ello, entonces no van a trabajar realmente duro.",
          "Mark Zuckerberg"),
      Quote(
          "Enero 31",
          "Nuestra mayor debilidad es rendirnos. La única manera de tener éxito es intentarlo siempre una vez más.",
          "Thomas Edison"),
      Quote(
          "Febrero 1",
          "Me he dado cuenta de que cuanto más trabajo, más suerte tengo.",
          "Thomas Jefferson"),
      Quote(
          "Febrero 2",
          "Compra cuando todo el mundo esté vendiendo y guarda dinero cuando los demás estén comprando. No se trata de un eslogan. Es la esencia de las inversiones exitosas.",
          "J. Paul Getty"),
      Quote("Febrero 3", "No hay sustituto para el trabajo duro.",
          "Thomas Edison"),
      Quote(
          "Febrero 4",
          "La mayoría de la gente deja pasar las oportunidades porque estas van vestidas de manera corriente y parecen trabajo.",
          "Thomas Edison"),
      Quote(
          "Febrero 5",
          "Creo que es más fácil avanzar hacia sueños muy ambiciosos.",
          "Larry Page"),
      Quote(
          "Febrero 6",
          "Hay una regla para el empresario: fabricar productos de la mayor calidad posible al menor coste y pagar los sueldos más altos posibles.",
          "Henry Ford"),
      Quote(
          "Febrero 7",
          "Compartir las ideas sin procesarlas puede conducirnos al engaño de pensar que en realidad estamos haciendo algo, cuando en realidad no estamos haciendo nada.",
          "Charles T. Lee"),
      Quote(
          "Febrero 8",
          "El hábito del ahorro es una educación: fomenta cada virtud, enseña autocontrol, cultiva el sentido del orden, desarrolla la previsión y amplía la mente.",
          "T.T. Munger"),
      Quote(
          "Febrero 9",
          "No gastes tu tiempo golpeando una pared, esperando transformarla en una puerta.",
          "Coco Chanel"),
      Quote(
          "Febrero 10",
          "Cómo tratas con el fracaso determina cómo consigues el éxito.",
          "David Feherty"),
      Quote(
          "Febrero 11",
          "La experiencia me enseñó que las mejores inversiones son las que uno no hace.",
          "Donald Trump"),
      Quote(
          "Febrero 12",
          "Observa, escucha y aprende. No puedes saberlo todo. Todo el que piensa que lo sabe todo está destinado a la mediocridad.",
          "Donald Trump"),
      Quote("Febrero 13", "Intenta lo imposible para mejorar tu trabajo.",
          "Brian Tracy"),
      Quote(
          "Febrero 14",
          "Si puedes soñarlo, puedes hacerlo. Recuerda que todo esto comenzó con un ratón.",
          "Walt Disney"),
      Quote(
          "Febrero 15",
          "Solo hay dos formas de vivir tu vida. Una es pensar que nada es un milagro. La otra es pensar que todo es un milagro.",
          "Albert Einstein"),
      Quote("Febrero 16", "Si te asusta, podría valer la pena intentarlo.",
          "Seth Godin"),
      Quote(
          "Febrero 17",
          "Definitivamente quería ganar mi libertad. Pero la principal motivación no fue hacer dinero, sino causar un impacto.",
          "Sean Parker"),
      Quote("Febrero 18", "La falta de dinero es la raíz de todo mal.",
          "Mark Twain"),
      Quote(
          "Febrero 19",
          "Sólo se puede vivir una vez. Y no quiero perder ni un minuto de mi vida.",
          "Richard Branson"),
      Quote(
          "Febrero 20",
          "El hombre se descubre cuando se mide contra un obstáculo.",
          "Antoine de Saint-Exupéry"),
      Quote(
          "Febrero 21",
          "El fracaso es solo la oportunidad de comenzar de nuevo de forma más inteligente.",
          "Henry Ford"),
      Quote(
          "Febrero 22",
          "Un negocio absolutamente dedicado al servicio solo tendrá una preocupación sobre las ganancias: serán demasiado grandes.",
          "Henry Ford"),
      Quote(
          "Febrero 23",
          "A alguna gente no le gusta el cambio, pero necesitas abrazarlo si la alternativa es el desastre.",
          "Elon Musk"),
      Quote("Febrero 24", "Haz lo que amas y el dinero llegará.",
          "Marsha Sinetar"),
      Quote("Febrero 25", "Para triunfar, primero debemos creer que podemos.",
          "Nikos Kazantzakis"),
      Quote(
          "Febrero 26",
          "El éxito es un pésimo profesor. Seduce a la gente inteligente para que piense que no puede perder.",
          "Bill Gates"),
      Quote("Febrero 27", "Si caes siete veces, levántate ocho.",
          "Proverbio japonés"),
      Quote(
          "Febrero 28",
          "Cuando tienes dinero, solo tú recuerdas quién eres. Pero cuando no tienes dinero, todo el mundo olvida quién eres. Así es la vida.",
          "Bill Gates"),
      Quote(
          "Marzo 1",
          "El éxito está conectado con la acción. Las personas exitosas siguen avanzando. Cometen errores, pero nunca se dan por vencidas.",
          "Conrad Hilton"),
      Quote(
          "Marzo 2",
          "Si tuviéramos que hablar más que escuchar, tendríamos dos bocas y solamente una oreja.",
          "Mark Twain"),
      Quote(
          "Marzo 3",
          "El riesgo más grande es no tomar ninguno. En un mundo que cambia tan rápido, la única estrategia cuyo fracaso está garantizado es no tomar riesgos.",
          "Mark Zuckerberg"),
      Quote(
          "Marzo 4",
          "Hacer o no hacer. No basta con intentarlo; hay que hacerlo.",
          "Yoda"),
      Quote(
          "Marzo 5",
          "El dinero no puede comprar amigos, pero puedes conseguir una nueva clase de enemigos.",
          "Anónimo"),
      Quote(
          "Marzo 6",
          "Tú serás exitoso porque la mayoría de personas son perezosas.",
          "Shahir Zag"),
      Quote(
          "Marzo 7",
          "Tanto si piensas que puedes, como si piensas que no puedes, estás en lo cierto.",
          "Henry Ford"),
      Quote("Marzo 8", "No trates de ser original, solo trata de ser bueno.",
          "Paul Rand"),
      Quote(
          "Marzo 9",
          "Tú eres una persona de éxito cuando tienes algunas de las cosas que el dinero puede comprar y todas las cosas que el dinero no puede comprar.",
          "Zig Ziglar"),
      Quote(
          "Marzo 10",
          "Solo existen dos días del año en los que no se puede hacer nada. Uno se llama ayer y otro, mañana. Por lo tanto, hoy es el día ideal para amar, crecer, actuar y, sobre todo, vivir.",
          "Dalai Lama"),
      Quote("Marzo 11", "El miedo no existe en otro lugar excepto en la mente.",
          "Dale Carnegie"),
      Quote(
          "Marzo 12",
          "Un cobarde es incapaz de mostrar amor; hacerlo está reservado para los valientes.",
          "Mahatma Gandhi"),
      Quote(
          "Marzo 13",
          "Hay hombres que luchan un día y son buenos. Hay otros que luchan un año y son mejores. Hay quienes luchan muchos años y son muy buenos. Pero los hay que luchan toda la vida. Esos son los imprescindibles.",
          "Bertolt Brecht"),
      Quote("Marzo 14", "El dinero no puede comprar vida.", "Bob Marley"),
      Quote(
          "Marzo 15",
          "El dinero es una herramienta. Te llevará a donde desees, pero no te reemplazará como conductor.",
          "Ayn Rand"),
      Quote(
          "Marzo 16",
          "El tiempo, la perseverancia y diez años de intentos acabarán por hacerte parecer un éxito de la noche a la mañana.",
          "Biz Stone"),
      Quote(
          "Marzo 17",
          "El optimismo es la cualidad más asociada con el éxito y la felicidad.",
          "Brian Tracy"),
      Quote("Marzo 18", "Me tomó 20 años tener éxito de la noche a la mañana.",
          "Woody Allen"),
      Quote(
          "Marzo 19",
          "Arriésgate más de lo que otros consideran seguro. Sueña más de lo que otros consideran práctico.",
          "Howard Schultz"),
      Quote(
          "Marzo 20",
          "Ganar dinero, en sí mismo, no es difícil. Lo difícil es ganarlo haciendo algo a lo que merezca la pena dedicar la vida.",
          "Carlos Ruiz Zafón"),
      Quote(
          "Marzo 21",
          "No te preocupes por el financiamiento si no lo necesitas. Hoy es más económico que nunca iniciar un negocio.",
          "Noah Everett"),
      Quote(
          "Marzo 22",
          "En las ideas es en donde reside nuestra fuerza y tanto mejor si las sostenemos con obstinación.",
          "Enzo Ferrari"),
      Quote(
          "Marzo 23",
          "Ten en mente que tu propósito y tu plan para lograrlo pueden modificarse de vez en cuando. Lo importante es que comprendas el valor de trabajar siempre con un objetivo en mente y un plan bien estructurado.",
          "Napoleon Hill"),
      Quote(
          "Marzo 24",
          "Si duplicas el número de experimentos que haces por año, vas a duplicar tu ingenio.",
          "Jeff Bezos"),
      Quote(
          "Marzo 25",
          "Deja de perseguir el dinero y empieza a perseguir la pasión.",
          "Tony Hsieh"),
      Quote(
          "Marzo 26",
          "La riqueza no consiste en tener grandes posesiones, sino en tener pocas necesidades.",
          "Epicteto"),
      Quote("Marzo 27", "Algunas veces se gana, algunas veces se aprende.",
          "John Maxwell"),
      Quote("Marzo 28", "Solo eres tan bueno como la gente que contratas.",
          "Ray Kroc"),
      Quote(
          "Marzo 29",
          "La inteligencia es un don, la amabilidad es una elección.",
          "Jeff Bezos"),
      Quote(
          "Marzo 30",
          "La simplicidad y el sentido común deberían ser la base de la planificación y la dirección estratégica.",
          "Ingvar Kamprad"),
      Quote(
          "Marzo 31",
          "El éxito es aprender a ir de fracaso en fracaso sin desesperarse.",
          "Winston Churchill"),
      Quote("Abril 1", "El precio es lo que pagas; el valor es lo que recibes.",
          "Warren Buffett"),
      Quote("Abril 2", "Nunca gastes tu dinero antes de tenerlo.",
          "Thomas Jefferson"),
      Quote(
          "Abril 3",
          "Le debo mi éxito a haber escuchado con respeto los mejores consejos y luego haber desaparecido para hacer exactamente lo contrario.",
          "G. K. Chesterton"),
      Quote(
          "Abril 4",
          "Un negocio que no hace más que dinero es un negocio pobre.",
          "Anónimo"),
      Quote(
          "Abril 5",
          "Cuando innovas, tienes que estar preparado para que la gente te diga que estás loco.",
          "Larry Ellison"),
      Quote(
          "Abril 6",
          "Aquellos que dicen que algo no puede hacerse, suelen ser interrumpidos por otros que lo están haciendo.",
          "Joel A. Barker"),
      Quote(
          "Abril 7",
          "Los que renuncian son más numerosos que los que fracasan.",
          "Henry Ford"),
      Quote(
          "Abril 8",
          "Mientras que el dinero no puede comprar felicidad, te permite elegir tu propia forma de desgracia.",
          "Groucho Marx"),
      Quote(
          "Abril 9",
          "El carácter no puede desarrollarse en la facilidad y la tranquilidad. Solo a través de las pruebas del sufrimiento se puede fortalecer el alma, inspirar la ambición y, finalmente, alcanzar el éxito.",
          "Helen Keller"),
      Quote(
          "Abril 10",
          "La vida es peligrosa, no por los que hacen el mal, sino por los que se sientan a ver lo que pasa.",
          "Albert Einstein"),
      Quote(
          "Abril 11",
          "Las personas no son recordadas por el número de veces que fracasan, sino por el número de veces que tienen éxito.",
          "Thomas Alva Edison"),
      Quote("Abril 12", "Cada persona forja su propio destino.", "Carlos Slim"),
      Quote(
          "Abril 13",
          "Puedes decirle cualquier cosa a la gente, pero la forma en que lo digas determinará cómo reacciona.",
          "John Rampton"),
      Quote(
          "Abril 14",
          "Creo que es posible que la gente normal elija ser extraordinaria.",
          "Elon Musk"),
      Quote(
          "Abril 15",
          "El éxito se mide por lo alto que rebotas después de tocar fondo.",
          "George Patton"),
      Quote(
          "Abril 16",
          "La competición te hace mejor, siempre, siempre te hace mejor, incluso si el competidor gana.",
          "Carlos Slim"),
      Quote(
          "Abril 17",
          "Adormecer el dolor por un rato te hará sentirlo luego con más intensidad.",
          "Albus Dumbledore"),
      Quote(
          "Abril 18",
          "Todo el progreso se lleva a cabo fuera de la zona de confort.",
          "Michael John Bobak"),
      Quote(
          "Abril 19",
          "Vale más hacer la cosa más insignificante del mundo que estar media hora sin hacer nada.",
          "Goethe"),
      Quote(
          "Abril 20",
          "Nunca agaches la cabeza. Mantenla siempre en alto, ganes o pierdas.",
          "Enzo Ferrari"),
      Quote(
          "Abril 21",
          "Aquel que se cree que sabe todo está cerrándose puertas.",
          "Donald Trump"),
      Quote(
          "Abril 22",
          "No he fracasado. He encontrado 10 mil formas que no funcionan.",
          "Thomas Edison"),
      Quote(
          "Abril 23",
          "Los líderes sobresalientes hacen todo lo posible por fomentar la autoestima de su personal. Si las personas creen en sí mismas, es increíble lo que pueden conseguir.",
          "Sam Walton"),
      Quote(
          "Abril 24",
          "Si no puedes volar, corre; si no puedes correr, camina; si no puedes caminar, gatea. Sin importar lo que hagas, sigue avanzando.",
          "Martin Luther King Jr."),
      Quote(
          "Abril 25",
          "Regla número 1: nunca pierdas dinero. Regla número 2: nunca olvides la regla número 1.",
          "Warren Buffett"),
      Quote(
          "Abril 26",
          "Me gustaría vivir como un hombre pobre con mucho dinero.",
          "Pablo Picasso"),
      Quote(
          "Abril 27",
          "No es el hombre que tiene poco, sino el que ansía más el que es pobre.",
          "Séneca"),
      Quote(
          "Abril 28",
          "Lo que realmente da forma a nuestra vida es el significado que damos a las cosas.",
          "Tony Robbins"),
      Quote(
          "Abril 29",
          "La persistencia es muy importante. No debes renunciar a menos que te veas obligado a hacerlo.",
          "Elon Musk"),
      Quote(
          "Abril 30",
          "Los amigos y las buenas maneras te llevarán donde el dinero no puede.",
          "Margaret Walker"),
      Quote(
          "Mayo 1",
          "Si solo trabajas en cosas que te gustan y te apasionan, no deberías necesitar un plan maestro para ver cómo resulta todo.",
          "Mark Zuckerberg"),
      Quote(
          "Mayo 2",
          "No pienses que el dinero lo hace todo o acabarás haciéndolo todo por el dinero.",
          "Voltaire"),
      Quote("Mayo 3", "Cuando aparezca un sueño, ¡agárralo!", "Larry Page"),
      Quote(
          "Mayo 4",
          "El fracaso es una gran oportunidad para empezar otra vez con más inteligencia.",
          "Henry Ford"),
      Quote(
          "Mayo 5",
          "Para inventar, necesitas una buena imaginación y una pila de basura.",
          "Thomas Edison"),
      Quote(
          "Mayo 6",
          "El dinero y el éxito no cambian a la gente; simplemente amplifican lo que ya hay.",
          "Will Smith"),
      Quote(
          "Mayo 7",
          "Solo hay una clase social que piensa más en el dinero que los ricos: los pobres.",
          "Oscar Wilde"),
      Quote(
          "Mayo 8",
          "Dentro de 20 años estarás más decepcionado por las cosas que no hiciste que por las que hiciste. Así que suelta amarras, navega lejos de puertos seguros, atrapa los vientos favorables en tus velas. Explora. Sueña.",
          "Mark Twain"),
      Quote(
          "Mayo 9",
          "Nada es particularmente difícil si lo divides en pequeños trabajos.",
          "Henry Ford"),
      Quote(
          "Mayo 10",
          "Un pequeño esfuerzo es el mejor sustituto de las excusas.",
          "Donald Trump"),
      Quote(
          "Mayo 11",
          "Nunca se puede cruzar el océano hasta que se tenga el coraje de perder de vista la costa.",
          "Cristóbal Colón"),
      Quote(
          "Mayo 12",
          "La educación formal te dará para vivir; la autoeducación te dará una fortuna.",
          "Jim Rohn"),
      Quote(
          "Mayo 13",
          "Se necesitan veinte años para crear una reputación y cinco minutos para arruinarla. Si lo piensas así, harás las cosas de manera diferente.",
          "Warren Buffett"),
      Quote("Mayo 14", "El dinero es un amo terrible pero un excelente siervo.",
          "P.T. Barnum"),
      Quote(
          "Mayo 15",
          "Alguien se sienta hoy a la sombra de un árbol que fue plantado hace mucho tiempo.",
          "Warren Buffett"),
      Quote(
          "Mayo 16",
          "Nuestra mayor debilidad radica en renunciar. La forma más segura de tener éxito es siempre intentarlo una vez más.",
          "Thomas Edison"),
      Quote(
          "Mayo 17",
          "Puede que el dinero no compre la felicidad, pero prefiero llorar en un Jaguar que en un autobús.",
          "Françoise Sagan"),
      Quote(
          "Mayo 18",
          "Celebra tu éxito. Encuentra algo de humor en tus fracasos.",
          "Sam Walton"),
      Quote(
          "Mayo 19",
          "Una persona debe fijar sus objetivos cuanto antes y dedicar toda su energía y talento a ellos.",
          "Walt Disney"),
      Quote(
          "Mayo 20",
          "No dejes que el miedo de perder sea mayor que la emoción de ganar.",
          "Robert Kiyosaki"),
      Quote(
          "Mayo 21",
          "El dinero no puede comprar la felicidad, pero seguro que te conseguirá una mejor clase de recuerdos.",
          "Ronald Reagan"),
      Quote(
          "Mayo 22",
          "El dinero no compra la felicidad, pero alivia el estrés.",
          "Besa Kosova"),
      Quote(
          "Mayo 23",
          "Escoge un trabajo que te guste, y nunca tendrás que trabajar ni un solo día de tu vida.",
          "Confucio"),
      Quote(
          "Mayo 24",
          "Nunca intento ganar dinero en el mercado de valores. Compro suponiendo que la bolsa podría cerrar al día siguiente y reabrir dentro de diez años.",
          "Warren Buffett"),
      Quote("Mayo 25", "Solo aquellos que están dormidos no cometen errores.",
          "Ingvar Kamprad"),
      Quote(
          "Mayo 26",
          "No todo lo que se puede contar cuenta y no todo lo que cuenta se puede contar.",
          "Albert Einstein"),
      Quote(
          "Mayo 27",
          "La voluntad obstinada de perseguir una ambición propia es verdaderamente una fuerza que puede hacer superar obstáculos.",
          "Enzo Ferrari"),
      Quote(
          "Mayo 28",
          "Nunca he soñado con el éxito. Siempre he trabajado para conseguirlo.",
          "Estée Lauder"),
      Quote(
          "Mayo 29",
          "El tiempo es tu recurso más importante. Puedes hacer mucho en diez minutos. Una vez que pasan, esos diez minutos se van para siempre. No son solo una sexta parte de una hora. Divide tu vida en unidades de diez minutos y desperdicia las menos posibles en actividades sin sentido.",
          "Ingvar Kamprad"),
      Quote(
          "Mayo 30",
          "Si realmente quieres hacer algo, encontrarás una manera. Si no, encontrarás una excusa.",
          "Jim Rohn"),
      Quote(
          "Mayo 31",
          "No necesitas tener una empresa de 100 personas para desarrollar esa idea.",
          "Larry Page"),
      Quote(
          "Junio 1",
          "Siempre que te pregunten si puedes hacer un trabajo, contesta que sí y ponte enseguida a aprender cómo se hace.",
          "Franklin D. Roosevelt"),
      Quote(
          "Junio 2",
          "Hay momentos en nuestras vidas en los que tenemos que reunir el valor para tomar decisiones que, por alguna razón, van contra nuestro sentido común, pero que nos han aconsejado personas sabias en quienes confiamos. Decidimos seguir adelante, a pesar de los riesgos y de ir contra la razón, porque creemos que el camino que otros han escogido es el correcto y la mejor opción.",
          "Howard Schultz"),
      Quote(
          "Junio 3",
          "¿Mi mayor motivación? Seguir retándome a mí mismo. Veo la vida como una larga educación universitaria que nunca tuve: todos los días aprendo algo nuevo.",
          "Richard Branson"),
      Quote("Junio 4", "Caemos para tener éxito.", "Mary Kay Ash"),
      Quote(
          "Junio 5",
          "Nadie debería recibir un dólar a menos que lo haya ganado justamente.",
          "Theodore Roosevelt"),
      Quote(
          "Junio 6",
          "Internet debe ser un medio de comunicación entre los pueblos que contribuya a la paz mundial. El principal objetivo de la alta tecnología es mejorar el nivel de vida de las personas.",
          "Larry Ellison"),
      Quote(
          "Junio 7",
          "Para la mayoría de las cosas importantes, encontrar el momento oportuno siempre es un problema. ¿Esperas un buen momento para renunciar a tu trabajo? Las estrellas nunca se alinearán y los semáforos nunca se pondrán en verde al mismo tiempo. El universo no conspira en tu contra, pero tampoco hace todo lo posible por acomodar las cosas. Las condiciones nunca son perfectas. «Algún día» es una enfermedad que llevará tus sueños a la tumba. Las listas de pros y contras son igual de malas. Si es importante para ti y quieres hacerlo en algún momento, hazlo y corrige el rumbo sobre la marcha.",
          "Tim Ferriss"),
      Quote(
          "Junio 8",
          "No trates de convertirte en un hombre de éxito sino en un hombre de valores.",
          "Albert Einstein"),
      Quote(
          "Junio 9",
          "El primer paso es establecer que algo es posible; después viene la probabilidad de lograrlo.",
          "Elon Musk"),
      Quote(
          "Junio 10",
          "Puedes ser joven sin dinero, pero no puedes ser viejo sin él.",
          "Tennessee Williams"),
      Quote(
          "Junio 11",
          "Demasiadas personas gastan el dinero que ganaron para comprar cosas que no quieren, para impresionar a gente que no les gusta.",
          "Will Rogers"),
      Quote(
          "Junio 12",
          "Hay una diferencia entre ser pobre y estar quebrado. Uno puede estar quebrado temporalmente, uno es pobre para toda la vida.",
          "Robert Kiyosaki"),
      Quote(
          "Junio 13",
          "Cuando tengas ochenta años y, en un momento tranquilo de reflexión, te cuentes la versión más personal de la historia de tu vida, el relato más conciso y significativo será la serie de elecciones que hayas hecho. Al final, somos nuestras elecciones.",
          "Jeff Bezos"),
      Quote(
          "Junio 14",
          "Nunca abandones un sueño por el tiempo que pueda llevarte realizarlo. El tiempo pasará de todas formas.",
          "Earl Nightingale"),
      Quote(
          "Junio 15",
          "En la inversión, lo que es cómodo es raramente rentable.",
          "Robert Arnott"),
      Quote("Junio 16", "Cuando dejas de soñar, dejas de vivir.",
          "Malcolm Forbes"),
      Quote(
          "Junio 17",
          "Puedes estar decepcionado si fracasas, pero estás acabado si no lo intentas.",
          "Beverly Sills"),
      Quote("Junio 18", "Fracasar no es perder; es no haberlo intentado.",
          "Xavier Gabriel"),
      Quote(
          "Junio 19",
          "Un campeón tiene miedo de perder. Los demás tienen miedo de ganar.",
          "Billie Jean King"),
      Quote(
          "Junio 20",
          "Una persona que nunca cometió un error nunca intentó algo nuevo.",
          "Albert Einstein"),
      Quote("Junio 21", "Cuando tenía dinero, todos me llamaban hermano.",
          "Anónimo"),
      Quote(
          "Junio 22",
          "La forma en que los jefes tratan a los empleados es exactamente cómo los empleados tratarán a los clientes.",
          "Sam Walton"),
      Quote(
          "Junio 23",
          "Está bien tener dinero y las cosas que el dinero puede comprar, pero también está bien comprobar de vez en cuando que no has perdido las cosas que el dinero no puede comprar.",
          "George Lorimer"),
      Quote(
          "Junio 24",
          "Si no te avergüenza la primera versión de tu producto, lo lanzaste muy tarde.",
          "Reid Hoffman"),
      Quote(
          "Junio 25",
          "La zona de confort es un lugar maravilloso, pero nada crece allí.",
          "Anónimo"),
      Quote(
          "Junio 26",
          "Te convertirás en alguien tan pequeño como el deseo que te controle, y en algo tan grande como sea tu aspiración dominante.",
          "James Allen"),
      Quote(
          "Junio 27",
          "Mickey Mouse surgió de mi imaginación en una libreta de dibujo, en un tren de Manhattan a Hollywood, cuando la empresa de mi hermano Roy y mía estaba en su punto más bajo y el desastre parecía estar a la vuelta de la esquina.",
          "Walt Disney"),
      Quote("Junio 28",
          "No tengo miedo de morir; tengo miedo de no intentarlo.", "Jay Z"),
      Quote(
          "Junio 29",
          "Debes ganar control sobre tu dinero o la falta del mismo te controlará a ti.",
          "Dave Ramsey"),
      Quote(
          "Junio 30",
          "No importa a cuántas personas ofendas, siempre que tu mensaje llegue a tus consumidores. A quienes no quieren ofender a nadie les digo: van a tener muchas dificultades para conseguir una publicidad con significado.",
          "Phil Knight"),
      Quote(
          "Julio 1",
          "Hay un motor poderoso dentro de cada ser humano que, una vez liberado, puede hacer realidad cualquier visión, sueño o deseo.",
          "Anthony Robbins"),
      Quote(
          "Julio 2",
          "El ingrediente más importante es levantarte y hacer algo. Es así de simple. Muchas personas tienen ideas, pero solo algunas deciden hacer algo al respecto hoy. No mañana. No la semana que viene. Hoy. El verdadero emprendedor actúa en lugar de soñar.",
          "Nolan Bushnell"),
      Quote(
          "Julio 3",
          "La confianza en sí mismo es el primer secreto del éxito.",
          "Ralph Waldo Emerson"),
      Quote(
          "Julio 4",
          "Recordar que moriré pronto es la herramienta más importante que he encontrado para tomar las grandes decisiones de la vida. Casi todo —las expectativas externas, el orgullo y el miedo a la vergüenza o al fracaso— desaparece al enfrentar la muerte, dejando solo lo verdaderamente importante. Recordar que uno va a morir es la mejor manera que conozco de evitar la trampa de pensar que hay algo que perder. Ya se está indefenso. No hay razón para no seguir al corazón.",
          "Steve Jobs"),
      Quote(
          "Julio 5",
          "Debes hacer cosas que realmente sean importantes, pero también debes divertirte, porque, si no, no tendrás éxito.",
          "Larry Page"),
      Quote(
          "Julio 6",
          "Te contaré el secreto para hacerte rico en Wall Street. Sé codicioso cuando otros tengan miedo y sé temeroso cuando otros sean codiciosos.",
          "Warren Buffett"),
      Quote(
          "Julio 7",
          "Cuando era joven, pensaba que el dinero era lo más importante en la vida. Ahora que soy mayor, sé que lo es.",
          "Oscar Wilde"),
      Quote(
          "Julio 8",
          "Todos tus sueños pueden hacerse realidad si tienes el coraje de perseguirlos.",
          "Walt Disney"),
      Quote(
          "Julio 9",
          "La felicidad no es la mera posesión de dinero; reside en la alegría del logro, en la emoción del esfuerzo creativo.",
          "Franklin D. Roosevelt"),
      Quote(
          "Julio 10",
          "El emprendimiento no es ni ciencia ni arte; es una práctica.",
          "Peter Drucker"),
      Quote("Julio 11", "La hierba es más verde donde la riegas.",
          "Neil Barringham"),
      Quote(
          "Julio 12",
          "Piensa en grande y no escuches a quienes te dicen que no puedes hacerlo. La vida es muy corta para pensar en pequeño.",
          "Tim Ferriss"),
      Quote(
          "Julio 13",
          "El crecimiento constante es el mejor mecanismo de supervivencia.",
          "Amancio Ortega"),
      Quote(
          "Julio 14",
          "Nunca serás un perdedor hasta que dejes de intentarlo.",
          "Mike Ditka"),
      Quote("Julio 15", "Las grandes ideas se originan en los músculos.",
          "Thomas Edison"),
      Quote(
          "Julio 16",
          "Construir una gran misión y una empresa van de la mano. Es cierto que lo que más me entusiasma de lo que hacemos es la misión, pero también creo que, desde el principio, hemos comprendido que debemos desarrollar ambas.",
          "Mark Zuckerberg"),
      Quote(
          "Julio 17",
          "Un verdadero perdedor es alguien que tiene tanto miedo a no ganar que no lo intenta.",
          "Anónimo"),
      Quote("Julio 18", "El tiempo es dinero.", "Benjamin Franklin"),
      Quote(
          "Julio 19",
          "Si solo trabajas por dinero, nunca lo conseguirás, pero si amas lo que haces y siempre pones primero al cliente, el éxito será tuyo.",
          "Ray Kroc"),
      Quote(
          "Julio 20",
          "La calidad de un líder se refleja en las normas que establece para sí mismo.",
          "Ray Kroc"),
      Quote("Julio 21", "El riesgo viene de no saber lo que estás haciendo.",
          "Warren Buffett"),
      Quote(
          "Julio 22",
          "Si buscas resultados distintos, no hagas siempre lo mismo.",
          "Albert Einstein"),
      Quote("Julio 23", "La travesía de mil millas comienza con un paso.",
          "Lao-Tsé"),
      Quote(
          "Julio 24",
          "El único límite a nuestros logros de mañana está en nuestras dudas de hoy.",
          "Franklin D. Roosevelt"),
      Quote("Julio 25", "Si quieres cambiar al mundo, cámbiate a ti mismo.",
          "Mahatma Gandhi"),
      Quote(
          "Julio 26",
          "Solo aquellos que se atreven a tener grandes fracasos terminan consiguiendo grandes éxitos.",
          "Robert F. Kennedy"),
      Quote(
          "Julio 27",
          "Si quieres vivir una vida feliz, átala a una meta no a una persona u objeto.",
          "Albert Einstein"),
      Quote(
          "Julio 28",
          "Por favor, piensa en tu legado, porque lo estás escribiendo todos los días.",
          "Gary Vaynerchuk"),
      Quote("Julio 29", "Toma en serio tus sueños.", "Gary Vaynerchuk"),
      Quote(
          "Julio 30",
          "El objetivo principal de una empresa es ganar dinero. La función primordial del Gobierno es tomar una gran parte de ese dinero y darla a los demás.",
          "Larry Ellison"),
      Quote(
          "Julio 31",
          "No se trata de cuánto dinero ganas, sino de cuánto ahorras, cuánto trabaja para ti y para cuántas generaciones durará.",
          "Robert Kiyosaki"),
      Quote("Agosto 1", "Hazlo con pasión, o no lo hagas.",
          "Rosa Nouchette Carey"),
      Quote(
          "Agosto 2",
          "La verdadera medida de tu riqueza es cuánto vales si pierdes todo tu dinero.",
          "Anónimo"),
      Quote(
          "Agosto 3",
          "Todo aquel que haya hecho algo importante en la vida ha sido disciplinado.",
          "Andrew Hendrixson"),
      Quote(
          "Agosto 4",
          "La vida es lo que ocurre mientras estamos ocupados haciendo planes.",
          "John Lennon"),
      Quote(
          "Agosto 5",
          "Tenemos que tener una meta, un propósito en nuestras vidas. Si no sabes adónde apuntas, no tienes una meta.",
          "Mary Kay Ash"),
      Quote(
          "Agosto 6",
          "Algunas personas sueñan con el éxito, mientras otras se despiertan y trabajan para lograrlo.",
          "Anónimo"),
      Quote(
          "Agosto 7",
          "Las personas que están lo suficientemente locas como para pensar que pueden cambiar el mundo son quienes lo cambian.",
          "Steve Jobs"),
      Quote(
          "Agosto 8",
          "La tragedia en la vida no consiste en no alcanzar tus metas. La tragedia en la vida es no tener metas que alcanzar.",
          "Benjamin E. Mays"),
      Quote("Agosto 9", "La riqueza fluye de la energía y de las ideas.",
          "William Feather"),
      Quote("Agosto 10", "El fracaso más grande es nunca haberlo intentado.",
          "Proverbio chino"),
      Quote("Agosto 11", "Una inversión en conocimiento paga el mejor interés.",
          "Benjamin Franklin"),
      Quote(
          "Agosto 12",
          "El pensamiento positivo te dejará hacer todo mejor que el negativo.",
          "Zig Ziglar"),
      Quote("Agosto 13", "Si vas a pensar de todas formas, piensa en grande.",
          "Donald Trump"),
      Quote(
          "Agosto 14",
          "Una persona inteligente debería tener dinero en su cabeza, no en su corazón.",
          "Jonathan Swift"),
      Quote(
          "Agosto 15",
          "En los momentos de crisis solo la imaginación es más importante que el conocimiento.",
          "Robert Kiyosaki"),
      Quote(
          "Agosto 16",
          "No es lo que tienes, sino cómo lo usas lo que marca la diferencia.",
          "Zig Ziglar"),
      Quote(
          "Agosto 17",
          "Sé un punto de referencia de calidad. Algunas personas no están acostumbradas a un ambiente donde la excelencia es aceptada.",
          "Steve Jobs"),
      Quote(
          "Agosto 18",
          "Casi todo lo que hagas será insignificante, pero es muy importante que lo hagas.",
          "Mahatma Gandhi"),
      Quote(
          "Agosto 19",
          "Nunca consideres el estudio como una obligación, sino como una oportunidad para penetrar en el bello y maravilloso mundo del saber.",
          "Albert Einstein"),
      Quote(
          "Agosto 20",
          "Tu tiempo es limitado, así que no lo desperdicies viviendo la vida de alguien más. No te dejes atrapar por el dogma, que es vivir con los resultados de los pensamientos de otras personas. No dejes que el ruido de las opiniones ajenas ahogue tu voz interior. Y lo más importante: ten el coraje de seguir a tu corazón y a tu intuición. De algún modo, ya saben lo que realmente quieres ser. Todo lo demás es secundario.",
          "Steve Jobs"),
      Quote(
          "Agosto 21",
          "Una buena idea es un 10 % de implementación y trabajo; el otro 90 % es suerte.",
          "Guy Kawasaki"),
      Quote("Agosto 22",
          "El arte no está en ganar dinero, sino en conservarlo.", "Anónimo"),
      Quote(
          "Agosto 23",
          "Está bien celebrar el éxito pero es más importante prestar atención a las lecciones del fracaso.",
          "Bill Gates"),
      Quote(
          "Agosto 24",
          "Mi meta nunca fue solo crear una empresa. Mucha gente lo malinterpreta, como si no me importaran las ganancias, los beneficios o cualquier otra cuestión de ese tipo. Pero, para mí, no ser simplemente otra empresa significa construir algo que realmente genere un gran cambio.",
          "Mark Zuckerberg"),
      Quote(
          "Agosto 25",
          "No importa qué tan lento vayas mientras no te detengas.",
          "Confucio"),
      Quote(
          "Agosto 26",
          "El éxito no se logra solo con cualidades especiales. Es sobre todo un trabajo de constancia, de método y de organización.",
          "Víctor Hugo"),
      Quote(
          "Agosto 27",
          "No te avergüences de tus fracasos; aprende de ellos y comienza de nuevo.",
          "Richard Branson"),
      Quote(
          "Agosto 28",
          "Solo hay un jefe. El cliente. Y él puede despedir a cualquiera en la compañía, desde el presidente hasta el último empleado, simplemente gastándose su dinero en otra parte.",
          "Sam Walton"),
      Quote(
          "Agosto 29",
          "Si estuviésemos motivados por el dinero, hubiésemos vendido Google y estaríamos en la playa.",
          "Larry Page"),
      Quote(
          "Agosto 30",
          "Sueña en grande. Comienza en pequeño. Pero, sobre todo, comienza.",
          "Simon Sinek"),
      Quote(
          "Agosto 31",
          "He perdido más de nueve mil oportunidades en mi carrera. He perdido casi 300 juegos. Me han confiado 26 veces el tiro ganador y he fallado. He fracasado una y otra vez en mi vida y por eso he tenido éxito.",
          "Michael Jordan"),
      Quote(
          "Septiembre 1",
          "No tengas miedo de renunciar a lo bueno para perseguir lo grandioso.",
          "John D. Rockefeller"),
      Quote("Septiembre 2", "Si tienes miedo de fallar, seguramente fallarás.",
          "Kobe Bryant"),
      Quote(
          "Septiembre 3",
          "Recuerda: hoy es el mañana por el que te preocupabas ayer.",
          "Dale Carnegie"),
      Quote(
          "Septiembre 4",
          "Pensar es el trabajo más difícil que existe. Quizá esa sea la razón por la que haya tan pocas personas que lo practiquen.",
          "Henry Ford"),
      Quote(
          "Septiembre 5",
          "¿Por qué contentarnos con vivir a rastras cuando sentimos el anhelo de volar?",
          "Helen Keller"),
      Quote(
          "Septiembre 6",
          "Ningún pesimista ha descubierto nunca el secreto de las estrellas, o navegado hacia una tierra sin descubrir, o abierto una nueva esperanza en el corazón humano.",
          "Helen Keller"),
      Quote(
          "Septiembre 7",
          "Puedes tener cualquier cosa que quieras en este mundo si la deseas lo suficiente como para pagar su precio.",
          "Mary Kay Ash"),
      Quote(
          "Septiembre 8",
          "Muchas personas no cuidan su dinero hasta que casi lo han gastado, y otras hacen lo mismo con su tiempo.",
          "Johann Wolfgang von Goethe"),
      Quote(
          "Septiembre 9",
          "El éxito no es la clave de la felicidad. La felicidad es la clave del éxito. Si amas lo que estás haciendo, tendrás éxito.",
          "Albert Schweitzer"),
      Quote(
          "Septiembre 10",
          "No puedes vivir 75 veces el mismo año y luego llamarlo vida.",
          "Robin Sharma"),
      Quote(
          "Septiembre 11",
          "Tienes que saber lo que va a pasar si quieres seguir estando un paso por delante.",
          "Phil Knight"),
      Quote(
          "Septiembre 12",
          "No te limites. Muchas personas se limitan a lo que creen que pueden hacer. Puedes llegar tan lejos como tu mente te permita. Recuerda: puedes lograr aquello en lo que creas.",
          "Mary Kay Ash"),
      Quote(
          "Septiembre 13",
          "La experiencia me ha enseñado unas cuantas cosas. La primera es escuchar mi intuición, sin importar cómo se vean las cosas sobre el papel. La segunda es que, por lo general, haces mejor aquello que conoces. Y la tercera es que tu mejor inversión puede ser aquella que no haces.",
          "Donald Trump"),
      Quote("Septiembre 14", "Lo que te hace crecer es la derrota, el error.",
          "Pep Guardiola"),
      Quote(
          "Septiembre 15",
          "Hasta que no te valores a ti mismo, no valorarás tu tiempo. Y hasta que no valores tu tiempo, no harás nada con él.",
          "M. Scott Peck"),
      Quote(
          "Septiembre 16",
          "No tiene nada de malo ser pequeño. Puedes hacer grandes cosas con un equipo así.",
          "Jason Fried"),
      Quote(
          "Septiembre 17",
          "No tengo grandes ideas. A veces tengo pequeñas ideas que parecen funcionar.",
          "Matt Mullenweg"),
      Quote(
          "Septiembre 18",
          "Cada vez que defines en qué quieres creer, eres el primero en escucharlo. Es un mensaje para ti y para los demás sobre lo que consideras posible. No te impongas un techo.",
          "Oprah Winfrey"),
      Quote("Septiembre 19",
          "Fracasa seguido para que puedas tener éxito pronto.", "Tom Kelley"),
      Quote(
          "Septiembre 20",
          "Mis cosas favoritas de la vida no cuestan dinero. Está claro que el recurso más preciado que tenemos es el tiempo.",
          "Steve Jobs"),
      Quote(
          "Septiembre 21",
          "Sentir rabia es como tomar veneno y esperar que muera la otra persona.",
          "Anónimo"),
      Quote(
          "Septiembre 22",
          "El dinero no es la única respuesta, pero marca una diferencia.",
          "Barack Obama"),
      Quote(
          "Septiembre 23",
          "Es mejor fracasar siendo original que tener éxito imitando.",
          "Herman Melville"),
      Quote(
          "Septiembre 24",
          "Mi ambición ha sido siempre hacer realizables los sueños.",
          "Bill Gates"),
      Quote(
          "Septiembre 25",
          "Quien hace más de lo que se le paga pronto recibirá más de lo que corresponde al trabajo que hace.",
          "Napoleon Hill"),
      Quote(
          "Septiembre 26", "Si puedes soñarlo, puedes lograrlo.", "Zig Ziglar"),
      Quote(
          "Septiembre 27",
          "Los campeones se mantienen jugando hasta que lo hacen bien.",
          "Billie Jean King"),
      Quote(
          "Septiembre 28",
          "Para que cualquier cosa suceda, primero hay que hacer algo.",
          "Albert Einstein"),
      Quote(
          "Septiembre 29",
          "No puedo darte una fórmula segura para el éxito, pero puedo darte una fórmula segura para el fracaso: Intenta complacer a todos, todo el tiempo.",
          "Herbert Bayard Swope"),
      Quote(
          "Septiembre 30",
          "Rico no es el que tiene riqueza, sino el que la disfruta.",
          "Benjamin Franklin"),
      Quote(
          "Octubre 1",
          "Es posible ganar más amigos en dos meses interesándonos por los demás que en dos años tratando de que los demás se interesen por nosotros.",
          "Dale Carnegie"),
      Quote(
          "Octubre 2",
          "En vez de pensar cuándo serán tus próximas vacaciones, deberías construir una vida de la que no quieras escapar.",
          "Seth Godin"),
      Quote(
          "Octubre 3",
          "Cuando hay una crisis, es cuando algunos están interesados en salir y nosotros estamos interesados en entrar.",
          "Carlos Slim"),
      Quote(
          "Octubre 4",
          "Si no estás dispuesto a arriesgarte a hacer lo inusual, tendrás que acostumbrarte a lo ordinario.",
          "Jim Rohn"),
      Quote(
          "Octubre 5",
          "La riqueza es la habilidad para experimentar totalmente la vida.",
          "Henry David Thoreau"),
      Quote(
          "Octubre 6",
          "Deja de esperar a que sea viernes, que sea verano, o que alguien te ame de por vida. La felicidad se alcanza cuando dejas de esperar y aprovechas al máximo el presente.",
          "T. Harv Eker"),
      Quote(
          "Octubre 7",
          "Siempre intenté convertir cada desastre en una oportunidad.",
          "John D. Rockefeller Jr."),
      Quote(
          "Octubre 8",
          "El éxito no es el resultado de una combustión espontánea. Tú tienes que encender la chispa primero.",
          "Fred Shero"),
      Quote(
          "Octubre 9",
          "Una persona exitosa es capaz de construir cimientos firmes con los ladrillos que le han lanzado los demás.",
          "David Brinkley"),
      Quote(
          "Octubre 10",
          "Hay dos tipos de personas que te dirán que no puedes marcar una diferencia en este mundo: las que tienen miedo de intentarlo y las que tienen miedo de que seas tú quien tenga éxito.",
          "Ray Goforth"),
      Quote(
          "Octubre 11",
          "Si quieres que algo sea hecho, nombra un responsable. Si quieres que algo se demore eternamente, nombra una comisión.",
          "Napoleón"),
      Quote(
          "Octubre 12",
          "Casi no fundé Google porque me preocupaban el riesgo y la idea de abandonar mi programa de doctorado.",
          "Larry Page"),
      Quote("Octubre 13", "La creatividad es la inteligencia divirtiéndose.",
          "Albert Einstein"),
      Quote(
          "Octubre 14",
          "Si el dinero es tu esperanza de independencia, nunca la tendrás. La única seguridad real que una persona tendrá en este mundo es una reserva de conocimiento, experiencia y habilidad.",
          "Henry Ford"),
      Quote("Octubre 15", "Hay gente que tiene dinero y hay gente que es rica.",
          "Coco Chanel"),
      Quote(
          "Octubre 16",
          "Hay dos tipos de empresas: las que trabajan para tratar de cobrar más, y las que trabajan para cobrar menos. Nosotros seremos de la segunda clase.",
          "Jeff Bezos"),
      Quote(
          "Octubre 17",
          "Eres responsable de los pensamientos que albergas en tu mente en cada momento. Tienes la capacidad de pensar lo que desees. Así, incluso tus actitudes y comportamientos negativos y autodestructivos tienen su origen en la manera en que has elegido pensar.",
          "Wayne Dyer"),
      Quote(
          "Octubre 18",
          "El cambio no solo es necesario en la vida; es la vida misma.",
          "Alvin Toffler"),
      Quote(
          "Octubre 19",
          "Puedes alcanzar cualquier cosa que quieras si vas a por ella.",
          "Wayne Dyer"),
      Quote(
          "Octubre 20", "Un líder es un negociador de esperanzas.", "Napoleón"),
      Quote(
          "Octubre 21",
          "No duermas para descansar, sino para soñar, porque los sueños están para cumplirse.",
          "Walt Disney"),
      Quote(
          "Octubre 22",
          "El mejor momento para plantar un árbol fue hace 20 años. El segundo mejor momento es ahora.",
          "Proverbio chino"),
      Quote(
          "Octubre 23",
          "Un negocio es simplemente una idea para mejorar la vida de otras personas.",
          "Richard Branson"),
      Quote(
          "Octubre 24",
          "No es el empleador el que paga el salario. Los empleadores solo manejan el dinero. Es el cliente el que paga el salario.",
          "Henry Ford"),
      Quote(
          "Octubre 25",
          "Mantente alejado de quienes tratan de menospreciar tus ambiciones. Las personas mezquinas siempre lo hacen, pero las verdaderamente grandes te hacen sentir que tú también puedes ser grande.",
          "Mark Twain"),
      Quote("Octubre 26", "Sé el cambio que quieres ver en el mundo.",
          "Mahatma Gandhi"),
      Quote(
          "Octubre 27",
          "Si no valoras tu tiempo, tampoco lo harán otros. Deja de regalar tu tiempo y talento. Valora lo que sabes y comienza a cobrar por ello.",
          "Kim Garst"),
      Quote(
          "Octubre 28",
          "En el mundo moderno de los negocios, es inútil ser un pensador creativo y original a menos que también vendas lo que creas.",
          "David Ogilvy"),
      Quote(
          "Octubre 29",
          "Destruyo mis enemigos cuando los convierto en mis amigos.",
          "Abraham Lincoln"),
      Quote(
          "Octubre 30",
          "La circulación de confianza es mejor que la circulación de dinero.",
          "James Madison"),
      Quote(
          "Octubre 31",
          "He tenido la fortuna de encontrar personas más inteligentes que yo; ellas me ayudan a hacer realidad mi visión.",
          "Russell Simmons"),
      Quote("Noviembre 1", "No estaba lloviendo cuando Noé construyó su arca.",
          "Howard Ruff"),
      Quote(
          "Noviembre 2",
          "Solo puedes realizarte completamente en algo que amas. Que tu meta no sea ganar dinero. En su lugar, persigue cosas que ames hacer y hazlas tan bien que la gente no pueda quitar sus ojos de ti.",
          "Maya Angelou"),
      Quote(
          "Noviembre 3",
          "En las batallas te das cuenta de que los planes son inservibles, pero planificar es indispensable.",
          "Dwight E. Eisenhower"),
      Quote(
          "Noviembre 4",
          "Ningún hombre será el mejor si no tiene fuego en la sangre.",
          "Enzo Ferrari"),
      Quote(
          "Noviembre 5",
          "Uno de los grandes errores que comete la gente es tratar de forzar su interés. Tú no eliges tus pasiones; tus pasiones te eligen a ti.",
          "Jeff Bezos"),
      Quote(
          "Noviembre 6",
          "No, no soy rico. Soy un hombre pobre con dinero, lo que no es lo mismo.",
          "Gabriel García Márquez"),
      Quote(
          "Noviembre 7",
          "Si vives para tenerlo todo, lo que tienes nunca es suficiente.",
          "Vicki Robin"),
      Quote("Noviembre 8", "Si no sueñas, no vas a lograr nada.",
          "Richard Branson"),
      Quote(
          "Noviembre 9",
          "Es fácil tener principios cuando eres rico. Lo más importante es tener principios cuando eres pobre.",
          "Ray Kroc"),
      Quote(
          "Noviembre 10",
          "Si estás en los negocios, necesitas entender el entorno, tener una visión del futuro y conocer el pasado.",
          "Carlos Slim"),
      Quote(
          "Noviembre 11",
          "Exígete mucho a ti mismo y espera poco de los demás; así te ahorrarás disgustos.",
          "Confucio"),
      Quote(
          "Noviembre 12",
          "Quien no esté cometiendo errores no lo está intentando lo suficiente.",
          "Wess Roberts"),
      Quote(
          "Noviembre 13",
          "No te disculpes por tener altos estándares. Las personas que realmente quieren estar en tu vida alcanzarán este nivel.",
          "Ziad K. Abdelnour"),
      Quote("Noviembre 14",
          "Es difícil derrotar a una persona que nunca se rinde.", "Babe Ruth"),
      Quote(
          "Noviembre 15",
          "Tú sabes que estás en el camino del éxito si estás dispuesto a hacer tu trabajo aun cuando no te paguen.",
          "Oprah Winfrey"),
      Quote("Noviembre 16",
          "El 80 % del éxito se basa simplemente en insistir.", "Woody Allen"),
      Quote(
          "Noviembre 17",
          "El valor de la vida puede ser medido por las veces en las que tu alma ha estado muy agitada.",
          "Soichiro Honda"),
      Quote(
          "Noviembre 18",
          "No basta con hacer productos buenos. Tienes que hacer que la gente se entere de lo que estás haciendo.",
          "Phil Knight"),
      Quote("Noviembre 19", "El dinero normalmente se atrae, no se persigue.",
          "Jim Rohn"),
      Quote(
          "Noviembre 20",
          "Solo triunfa en el mundo quien se levanta, busca las circunstancias que necesita y las crea si no las encuentra.",
          "George Bernard Shaw"),
      Quote(
          "Noviembre 21",
          "El valiente puede no vivir para siempre, pero el cauteloso no vive en absoluto.",
          "Richard Branson"),
      Quote(
          "Noviembre 22",
          "Solo trabajo con los mejores. No se trata de los mejores currículos, sino de la actitud correcta.",
          "Donald Trump"),
      Quote("Noviembre 23", "Las altas expectativas son la clave de todo.",
          "Sam Walton"),
      Quote(
          "Noviembre 24",
          "Cuando todo parezca ir en tu contra, recuerda que el avión despega contra el viento.",
          "Henry Ford"),
      Quote(
          "Noviembre 25",
          "El que tiene mucho no es rico, sino el que da mucho.",
          "Erich Fromm"),
      Quote(
          "Noviembre 26",
          "No hay secretos para el éxito. Este se alcanza preparándose, trabajando arduamente y aprendiendo del fracaso.",
          "Colin Powell"),
      Quote(
          "Noviembre 27",
          "Si el plan no funciona, cámbialo, pero nunca cambies tu objetivo.",
          "Anónimo"),
      Quote(
          "Noviembre 28",
          "Lo imposible es el fantasma de los tímidos y el refugio de los cobardes.",
          "Napoleón"),
      Quote(
          "Noviembre 29",
          "Las ideas son fáciles; ponerlas en práctica es lo difícil.",
          "Guy Kawasaki"),
      Quote(
          "Noviembre 30",
          "Presta atención a las críticas y pídelas, especialmente a tus amigos. Casi nadie lo hace y es de gran ayuda.",
          "Elon Musk"),
      Quote(
          "Diciembre 1",
          "El fracaso derrota a los perdedores e inspira a los ganadores.",
          "Robert Kiyosaki"),
      Quote(
          "Diciembre 2",
          "Los medios quieren éxitos de la noche a la mañana. Ignóralos. Ignora también a los inversionistas que quieren tácticas probadas y resultados instantáneos y previsibles. Escucha en cambio a tus clientes, a tu propia visión y haz algo que dure mucho tiempo.",
          "Seth Godin"),
      Quote(
          "Diciembre 3",
          "Un emprendedor ve oportunidades allá donde otros solo ven problemas.",
          "Michael Gerber"),
      Quote("Diciembre 4", "Es necesario anticipar un cierto grado de fracaso.",
          "Jeff Bezos"),
      Quote("Diciembre 5", "La vida no es justa; acostúmbrate a ello.",
          "Bill Gates"),
      Quote(
          "Diciembre 6",
          "El dinero es algo que entiendo vagamente y pienso en él solo cuando no lo tengo para financiar mis proyectos.",
          "Walt Disney"),
      Quote(
          "Diciembre 7",
          "Son muchas las manos y los corazones que contribuyen al éxito de una persona.",
          "Henry Ford"),
      Quote("Diciembre 8", "Respeta las reglas del juego, pero sé feroz.",
          "Phil Knight"),
      Quote(
          "Diciembre 9",
          "El único lugar donde el éxito viene antes que el trabajo es en el diccionario.",
          "Vidal Sassoon"),
      Quote(
          "Diciembre 10",
          "La forma de empezar es dejar de hablar y empezar a hacerlo.",
          "Walt Disney"),
      Quote(
          "Diciembre 11",
          "El camino hacia el éxito y el camino hacia el fracaso son muy parecidos. Solo los diferencia el final.",
          "Colin Davis"),
      Quote(
          "Diciembre 12",
          "El secreto de la felicidad no es hacer siempre lo que se quiere, sino querer siempre lo que se hace.",
          "Tolstoi"),
      Quote(
          "Diciembre 13",
          "El peor problema de contaminación que encaramos hoy en día es la negatividad.",
          "Mary Kay Ash"),
      Quote(
          "Diciembre 14",
          "No hay camino a la felicidad. La felicidad es el camino.",
          "Thich Nhat Hanh"),
      Quote(
          "Diciembre 15",
          "La imaginación es el principio de la creación. Imaginamos lo que queremos, creamos un profundo deseo por aquello que imaginamos y, finalmente, creamos aquello que hemos deseado.",
          "George Bernard Shaw"),
      Quote(
          "Diciembre 16",
          "Si uno avanza confiadamente en la dirección de sus sueños y deseos para llevar la vida que ha imaginado, se encontrará con un éxito inesperado.",
          "Henry David Thoreau"),
      Quote(
          "Diciembre 17",
          "No nos atrevemos a muchas cosas porque son difíciles, pero son difíciles porque no nos atrevemos a hacerlas.",
          "Lucio Anneo Séneca"),
      Quote(
          "Diciembre 18",
          "Todo aquello que puedas hacer o sueñes con hacer, comiénzalo. La audacia contiene en sí misma genio, poder y magia.",
          "Goethe"),
      Quote(
          "Diciembre 19",
          "Cada vez que pides dinero prestado, estás robándole dinero a tu futuro.",
          "Nathan W. Morris"),
      Quote(
          "Diciembre 20",
          "El éxito llega normalmente a quienes están demasiado ocupados para buscarlo.",
          "Henry David Thoreau"),
      Quote(
          "Diciembre 21",
          "Nunca me he considerado ingeniero ni inventor; solo me considero un promotor y agitador de ideas.",
          "Enzo Ferrari"),
      Quote(
          "Diciembre 22",
          "El guerrero exitoso es un hombre común con una concentración semejante a la de un láser.",
          "Bruce Lee"),
      Quote(
          "Diciembre 23",
          "El precio del éxito es el trabajo duro y la determinación de dar lo mejor de ti en el proyecto, sin importar si ganas o pierdes.",
          "Vince Lombardi"),
      Quote(
          "Diciembre 24",
          "Lo importante no son las ideas, sino hacer que se vuelvan realidad.",
          "Scott Belsky"),
      Quote(
          "Diciembre 25",
          "Lo más curioso acerca del juego de la vida es que cuando nos rehusamos a conformarnos con segundos lugares y decidimos salir tras lo mejor de lo mejor, generalmente lo obtenemos.",
          "Somerset Maugham"),
      Quote(
          "Diciembre 26",
          "El secreto para contratar a los mejores es este: busca personas que quieran cambiar el mundo.",
          "Marc Benioff"),
      Quote(
          "Diciembre 27",
          "Tus clientes más insatisfechos son tu mayor fuente de aprendizaje.",
          "Bill Gates"),
      Quote(
          "Diciembre 28",
          "El placer en el trabajo lleva a la perfección de la obra.",
          "Aristóteles"),
      Quote(
          "Diciembre 29",
          "Muchos de nuestros sueños parecen al principio imposibles, luego pueden parecer improbables, y luego, cuando nos comprometemos firmemente, se vuelven inevitables.",
          "Christopher Reeve"),
      Quote(
          "Diciembre 30",
          "Si no sabes qué hacer con tu vida, haz algo que salve vidas. El mundo está lleno de personas con necesidades; forma parte de sus vidas y ayúdalas a satisfacerlas.",
          "Sanjeev Saxena"),
      Quote(
          "Diciembre 31",
          "Crece con disciplina. Equilibra tu intuición con rigor. Innova alrededor de lo esencial. No aceptes el statu quo. Encuentra nuevas formas de ver. No esperes una solución milagrosa. Ponte manos a la obra. Escucha con empatía y comunica con transparencia.",
          "Howard Schultz"),
      Quote("Febrero 29", "El mejor modo de predecir el futuro es inventarlo.",
          "Alan Kay")
    ]);
  }

  Quote forDate(DateTime date) {
    final dayKey = '${_months[date.month - 1]} ${date.day}';
    return quotes.firstWhere((quote) => quote.date == dayKey);
  }

  Quote randomQuote() {
    return quotes.elementAt(Random().nextInt(quotes.length));
  }
}
