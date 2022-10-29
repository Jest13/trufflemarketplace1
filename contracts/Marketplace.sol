pragma solidity 0.8.7;


contract Exercice {

  address public owner;

  constructor(){
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "[WARNING] --- NOT OWNER --- [WARNING]");
    _;
  }

  // commande = 0
  // expedie = 1
  // livre = 2

  enum etape {commande, expedie, livre}


  // chaque produit a un identifiant unique et une étape
  struct produit {
    //produit
    uint _SKU;
    //produit
    Exercice.etape _etape;
  }

  mapping(address => produit) CommandesClient;

  //lorsque que l'utilisateur commande le produit l'étape passe à commander

  function commander(address _client, uint _SKU) public {
    produit memory p = produit(_SKU, etape.commande);
    CommandesClient[_client] = p;
  }

  // l'étape pour un objet (x) commandé par un client (x) est maintenant en expedition
  // EXPEDIER NE PEUT ETRE APPELER QUE PAR LE OWNER

  function expedier(address _client) external onlyOwner {
    CommandesClient[_client]._etape = etape.expedie;
  }

  // l'étape pour un objet (x) commandé par un client (x) est maintenant en livré
  // LIVRER NE PEUT ETRE APPELER QUE PAR LE OWNER

  function livre(address _client) external onlyOwner {
    CommandesClient[_client]._etape = etape.livre;
  }

  // permet de recuperer le SKU de l'objet rattaché à un client

  function getSKU(address _client) public view returns(uint){
    return CommandesClient[_client]._SKU;
  }

  function setOwner(address _newOwner) external onlyOwner {
    require(_newOwner != address(0), "[WARNING] --- INVALID ADRESS --- [WARNING]");
    owner = _newOwner;
  }

  function getEtape(address _client) public view returns(etape){
    return CommandesClient[_client]._etape;
  }

}