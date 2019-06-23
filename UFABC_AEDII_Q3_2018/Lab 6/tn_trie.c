#include "tn_trie.h"

void print_helper(tn_trie_node* root, string prefix);
bool has_no_children(tn_trie_node* node);

char ALPHABET[] = {'.', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',\
                   'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', \
                   'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', \
                   'u', 'v', 'w', 'x', 'y', 'z'};


int get_index(char c){
	if(c >= 'a' && c <= 'z'){
		return c - 'a' + 11;
	} else if(c >= 'A' && c <= 'Z'){
		return c - 'A' + 11;
	} else if(c == '.'){
		return 0;
	} else if(c >= '0' && c <= '9') {
		return c - '0' + 1;
	} 
	// nao identificou letra
	return -1;
}

tn_trie_node *new_node() {
	tn_trie_node* node = new tn_trie_node;
	node->is_end_of_word = false;
	for(int i = 0; i < ALPHABET_LENGTH; ++i){
		node->children[i] = NULL;
	}
	return node;
}

int insert(tn_trie_node* root, string key) {
	tn_trie_node* x = root;
	int index = -1;
	for(int i = 0; i < key.length(); ++i){
		index = get_index(key[i]);
		if(index >= 0){
			if(x->children[index] == NULL){
				x->children[index] = new_node();
			}
			x = x->children[index];
		} else{
			break;
		}
	}
	if (index < 0) return -1;
	else {
		x->is_end_of_word = true;
		return 0;	
	}
}

bool search(tn_trie_node *root, string key){
	tn_trie_node* x = root;
	if(root == NULL) return false;
	int index = -1;
	for(int i = 0; i < key.length(); ++i){
		index = get_index(key[i]);
		if(index < 0) break;
		if(x->children[index] == NULL) return false;
		x = x->children[index];
	}
	return(index >= 0 && x != NULL && x->is_end_of_word);
}

bool has_no_children(tn_trie_node* node){
	bool result = true;
	for(int i = 0; i <= ALPHABET_LENGTH; ++i){
		if(node->children[i] != NULL) {
			result = false;
			break;
		}
	}
	return result;
}

void print_all(tn_trie_node* root){	
	string prefix = "";
	print_helper(root, prefix);
}

void print_helper(tn_trie_node* root, string prefix){
	if(root->is_end_of_word){
		cout << prefix << endl;
	}
	if(has_no_children(root)) {
		return;
	}
	for(int i = 0; i < ALPHABET_LENGTH; ++i){
		if(root->children[i] != NULL) {
			prefix.push_back(ALPHABET[i]);
			print_helper(root->children[i], prefix);
			if(prefix.size() > 0) prefix.erase(prefix.size() - 1);
		}
	}
}
