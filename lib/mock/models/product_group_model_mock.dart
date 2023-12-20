import 'package:ismart/core/models/product_category_model.dart';
import 'package:ismart/core/models/product_group_model.dart';

List<ProductGroupModel> generateProductGroupModelMock() {
  return [
    ProductGroupModel(
      id: "1",
      title: "Brinquedos",
      icon: "lib/assets/product_groups/toys.png",
      categories: [
        ProductCategoryModel(id: "1", name: "Jogos de tabuleiros"),
        ProductCategoryModel(id: "2", name: "Puzzles e cartas"),
        ProductCategoryModel(id: "3", name: "Constructions e Legos"),
        ProductCategoryModel(id: "4", name: "Bonecos e bonecas"),
        ProductCategoryModel(id: "5", name: "Educations e criativos"),
        ProductCategoryModel(id: "6", name: "Tecnologia infantil"),
        ProductCategoryModel(id: "7", name: "Veículos infantis"),
        ProductCategoryModel(id: "8", name: "Telecomandos"),
        ProductCategoryModel(id: "9", name: "Carrinhas e pistas"),
        ProductCategoryModel(id: "10", name: "Funko Pop E merchandising"),
        ProductCategoryModel(id: "11", name: "Brinquedos de bebé"),
        ProductCategoryModel(id: "12", name: "Ar livre"),
        ProductCategoryModel(id: "13", name: "Nerfs e bisnagas"),
        ProductCategoryModel(id: "14", name: "Festas"),
      ],
    ),
    ProductGroupModel(
      id: "2",
      title: "Smartphones",
      icon: "lib/assets/product_groups/eletronics.png",
      categories: [
        ProductCategoryModel(id: "15", name: "Celulares"),
        ProductCategoryModel(id: "16", name: "Smartphones"),
        ProductCategoryModel(id: "17", name: "Smartwatches"),
        ProductCategoryModel(id: "18", name: "Acessórios para smartphones"),
        ProductCategoryModel(id: "19", name: "Capas para smarthphones"),
      ],
    ),
    ProductGroupModel(
      id: "3",
      title: "Mercearia",
      icon: "lib/assets/product_groups/grocery.png",
      categories: [
        ProductCategoryModel(id: "20", name: "Cereais e barras"),
        ProductCategoryModel(id: "21", name: "Bolachas"),
        ProductCategoryModel(id: "22", name: "Chocolate e doces"),
        ProductCategoryModel(id: "23", name: "Arroz, massa e farinha"),
        ProductCategoryModel(id: "24", name: "Azeite, óleo e vinagre"),
        ProductCategoryModel(id: "25", name: "Conservas"),
        ProductCategoryModel(id: "27", name: "Snacks e batatas fritas"),
        ProductCategoryModel(id: "28", name: "Frutas"),
        ProductCategoryModel(id: "29", name: "Legumes e verduras"),
      ],
    ),
    ProductGroupModel(
      id: "4",
      title: "Joias",
      icon: "lib/assets/product_groups/jewels.png",
      categories: [
        ProductCategoryModel(id: "30", name: "Brincos"),
        ProductCategoryModel(id: "31", name: "Colares"),
        ProductCategoryModel(id: "32", name: "Pulseiras"),
        ProductCategoryModel(id: "33", name: "Acessórios"),
      ],
    ),
    ProductGroupModel(
      id: "5",
      title: "Ferramentas",
      icon: "lib/assets/product_groups/mecanic.png",
      categories: [
        ProductCategoryModel(id: "33", name: "Chaves"),
        ProductCategoryModel(id: "34", name: "Parafusos"),
        ProductCategoryModel(id: "35", name: "Pregos"),
      ],
    ),
    ProductGroupModel(
      id: "6",
      title: "Móveis",
      icon: "lib/assets/product_groups/furniture.png",
      categories: [
        ProductCategoryModel(id: "36", name: "Cadeiras"),
        ProductCategoryModel(id: "37", name: "Mesas"),
        ProductCategoryModel(id: "38", name: "Poltronas"),
        ProductCategoryModel(id: "39", name: "Sofás"),
        ProductCategoryModel(id: "40", name: "Decoração"),
      ],
    ),
  ];
}
