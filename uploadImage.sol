pragma solidity 0.5.0;

contract Decentragram {
  string public name = 'Decentragram';
  
  struct Image {
    uint id;
    string hash;
    string description;
    uint tipAmount;
    address author;
  }

  event ImageCreated(
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address author
  );

  event ImageTipped(
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address author
  );
  // store Images
  uint public imageCount = 0;
  mapping(uint => Image) public images;
  
  // create Images
  function uploadImage(string memory _imgHash, string memory _description) payable public {
    // require conditions
    require(bytes(_imgHash).length > 0, 'Need image hash');
    require(bytes(_description).length > 0, 'No description provided');
    require(msg.sender != address(0x0), 'Invalid Address');
    // increment image count
    imageCount++;
    images[imageCount] = Image(imageCount,_imgHash,_description,0,address(msg.sender));

    // Trigger the event
    emit ImageCreated(imageCount, _imgHash, _description, 0, address(msg.sender));
  }

  // tip Images
  function tipImageOwner(uint _id) public payable {
    // make sure id is valid
    require(_id> 0 && _id <= imageCount, 'Id is not valid');
    // fetch the image
    Image memory _image = images[_id];
    // fetch the author
    address _author = address (_image.author);
    // Fetch the author
    payable(_author).transfer(msg.value);
    //address(payable(_author)).transfer(msg.value);

    _image.tipAmount += msg.value;
    images[_id] = _image;

    // Trigger the event
    emit ImageTipped(_id, _image.hash,_image.description, _image.tipAmount, _author);
  }
}